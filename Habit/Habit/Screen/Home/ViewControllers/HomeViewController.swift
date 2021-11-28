//
//  HomeViewController.swift
//  Habit
//
//  Created by 노한솔 on 2021/09/28.
//

import UIKit

import Moya
import RxSwift
import SnapKit
import Then

// MARK: - HomeViewController

final class HomeViewController: BaseViewController {
    
    // MARK: - Lazy Components
    
    private lazy var habitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 375.adjusted, height: 242.adjusted)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        return collectionView
    }()
    
    // MARK: - Components
    
    private let navigationView = CustomNavigationBar().then {
        $0.backgroundColor = .homeBackground
        $0.backBtn.setBackgroundImage(UIImage(named: "searchIcon"), for: .normal)
        $0.alpha = 0.6
    }
    
    private let plusButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setRounded(radius: 30.adjusted)
        $0.addTarget(self, action: #selector(touchUpPlusButton), for: .touchUpInside)
    }
    
    private let plusIcon = UIImageView().then {
        $0.image = UIImage(named: "plusIcon")
    }
    
    // MARK: - Variables
    
    private let networkService = NetworkService(
        provider: MoyaProvider<NetworkRouter>(
            plugins: [NetworkLoggerPlugin(verbose: true)]
        )
    )
    
    var habitModel: [QuestModel]?
    
    var socialModel: [SimpleSocial] = [
        SimpleSocial(imageName: "", backgroundColor: .softGreen, message: "물마시기를 완료했어요!", name: "이순신"),
        SimpleSocial(imageName: "", backgroundColor: .lightishBlue, message: "달리기를 새로 등록했어요!", name: "장보고"),
        SimpleSocial(imageName: "", backgroundColor: .darkPeriwinkle, message: "축구를 한 경기 뛰었어요!", name: "손흥민"),
        SimpleSocial(imageName: "", backgroundColor: .softGreen, message: "알고리즘을 풀었어요!", name: "황보경"),
        SimpleSocial(imageName: "", backgroundColor: .lightishBlue, message: "비타민을 먹었어요!", name: "노한솔"),
        SimpleSocial(imageName: "", backgroundColor: .darkPeriwinkle, message: "스트레칭을 완료했어요!", name: "김무명"),
        SimpleSocial(imageName: "", backgroundColor: .softGreen, message: "물마시기를 완료했어요", name: "이무명"),
        SimpleSocial(imageName: "", backgroundColor: .lightishBlue, message: "물마시기를 완료했어요", name: "송무명")
    ]
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchQuest()
    }
    
}

// MARK: - Extensions

extension HomeViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .homeBackground
        
        view.adds(
            [
                navigationView,
                habitCollectionView,
                plusButton,
                plusIcon
            ]
        )
        
        navigationView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(108.adjusted)
        }
        
        var count: CGFloat = 0
        if let model = habitModel {
            count = CGFloat(model.count)
        }
        
        habitCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.navigationView.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(198.adjusted + (132.adjusted*count))
        }
        
        plusButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-34.adjusted)
            $0.trailing.equalToSuperview().offset(-16.adjusted)
            $0.width.height.equalTo(60.adjusted)
        }
        
        plusIcon.snp.makeConstraints {
            $0.center.equalTo(self.plusButton)
            $0.width.height.equalTo(32.adjusted)
        }
    }
    
    private func relayout() {
        var count: CGFloat = 0
        if let model = habitModel {
            count = CGFloat(model.count)
        }
        
        habitCollectionView.snp.updateConstraints {
            $0.height.equalTo(198.adjusted + (132.adjusted*count))
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        habitCollectionView.delegate = self
        habitCollectionView.dataSource = self
        
        habitCollectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier
        )
        
        habitCollectionView.register(
            HabitCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HabitCollectionReusableView.identifier
        )
    }
    
    private func pushToAddHabitSecondViewController(model: QuestModel, habitID: String) {
        let secondVC = AddHabitSecondViewController()
        secondVC.rootViewController = self
        var requestModel = QuestRequestModel.init(model: model)
        secondVC.habitModel = requestModel
        secondVC.habitID = habitID
        secondVC.configTitle(name: model.title, isDetail: true)
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchUpPlusButton() {
        let addHabitVC = AddHabitMainViewController()
        addHabitVC.rootViewController = self
        self.navigationController?.pushViewController(addHabitVC, animated: true)
    }
    
    // MARK: - Server Helpers
    
    func fetchQuest() {
        networkService.fetchQuest()
            .subscribe(onNext: { response in
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(QuestResponseModel.self, from: response.data)
                        self.habitModel = data.questResponses
                        self.relayout()
                        self.habitCollectionView.reloadData()
                    }
                    catch {
                        print(error)
                    }
                }
            }, onError: { error in
                print(error)
            }, onCompleted: {}).disposed(by: disposeBag)
    }
    
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjusted, height: 120.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 178.adjusted)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let habitCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath)
                as? HabitCollectionViewCell else { return UICollectionViewCell() }
        if let model = habitModel {
            habitCell.dataBind(model: model[indexPath.item])
        }
        return habitCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HabitCollectionReusableView.identifier,
                for: indexPath)
                    as? HabitCollectionReusableView else { return UICollectionReusableView() }
            
            headerView.socialModel = socialModel
            headerView.reloadCollectionView()
            return headerView
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = habitModel {
            pushToAddHabitSecondViewController(model: model[indexPath.item], habitID: model[indexPath.item].id)
        }
    }
}
