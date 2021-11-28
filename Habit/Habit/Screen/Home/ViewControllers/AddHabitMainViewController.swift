//
//  AddHabitMainViewController.swift
//  Habit
//
//  Created by 노한솔 on 2021/10/26.
//

import UIKit

import Moya
import RxSwift
import SnapKit
import Then

// MARK: - AddHabitMainViewController

final class AddHabitMainViewController: BaseViewController {

    // MARK: - Lazy Components
    
    private lazy var firstSuggestionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        return collectionView
    }()
    
    private lazy var secondSuggestionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        return collectionView
    }()
    
    private lazy var joinExistingHabitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        return collectionView
    }()
    
    // MARK: - Components
    
    private let containerView = UIScrollView()
    private let navigationView = CustomNavigationBar().then {
        $0.backgroundColor = .homeBackground
        $0.backBtn.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.setupLabel(
            text: "새로운 습관의 이름을\n알려주세요.",
            color: .black,
            font: .SFDisplaySemibold(fontSize: 20.adjusted)
        )
    }
    
    private let habitNameTextField = UITextField().then {
        $0.font = .SFTextSemibold(fontSize: 13.adjusted)
        $0.textColor = .black
        $0.backgroundColor = .white
        $0.addLeftPadding(as: 14.adjusted)
        $0.setRounded(radius: 8.adjusted)
        $0.returnKeyType = .next
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
    }
    
    private let confirmButton = UIButton().then {
        $0.setupButton(
            title: "등록",
            color: .white,
            font: .SFTextSemibold(fontSize: 13.adjusted),
            backgroundColor: .lightishBlue,
            state: .normal,
            radius: 8.adjusted
        )
    }
    private let applyByIDButton = UIButton().then {
        $0.setupButton(
            title: "습관 ID로 등록하기",
            color: .lightishBlue,
            font: .SFTextMedium(fontSize: 12.adjusted),
            backgroundColor: .clear,
            state: .normal,
            radius: 0
        )
        
        $0.addTarget(self, action: #selector(touchUpByIDButton), for: .touchUpInside)
    }
    
    private let habitSuggestionTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "이런 습관은 어떠세요?",
            color: .black,
            font: .SFTextSemibold(fontSize: 13.adjusted)
        )
    }
    
    private let joinHabitTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "진행중인 습관 참여하기",
            color: .black,
            font: .SFTextSemibold(fontSize: 13.adjusted)
        )
    }
    
    private var halfContainerView = HalfAppearView.shared.then {
        $0.halfView.backgroundColor = .white
        $0.isMenu = false
    }
    
    private var halfView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.setRounded(radius: 15.adjusted)
    }
    
    private let halfViewTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "습관 ID로 등록하기",
            color: .black,
            font: .SFTextSemibold(fontSize: 20.adjusted)
        )
    }
    
    private let habitIDTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "습관 ID",
            color: .brownGrey,
            font: .SFTextRegular(fontSize: 13.adjusted)
        )
    }
    
    private let habitIDTextField = UITextField().then {
        $0.addLeftPadding(as: 14.adjusted)
        $0.backgroundColor = .homeBackground
        $0.setRounded(radius: 8.adjusted)
        $0.font = .SFTextRegular(fontSize: 13.adjusted)
        $0.textColor = .black
        $0.keyboardType = .default
    }
    
    private let halfViewButton = UIButton().then {
        $0.setupButton(
            title: "확인",
            color: .white,
            font: .SFTextSemibold(fontSize: 15.adjusted),
            backgroundColor: .lightishBlue,
            state: .normal,
            radius: 16.adjusted
        )
    }
    
    // MARK: - Variables
    
    private let networkService = NetworkService(
        provider: MoyaProvider<NetworkRouter>(
            plugins: [NetworkLoggerPlugin(verbose: true)]
        )
    )
    
    var habitModelWithID: QuestRequestModel?
    var halfViewOriginFrame: CGRect?
    var rootViewController: UIViewController?
    
    var habitModel: [QuestModel] = [
        QuestModel(id: "", title: "3km달리기", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 31, accomplishable: false),
        QuestModel(id: "", title: "금연", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 12, accomplishable: false),
        QuestModel(id: "", title: "물 2리터", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 32, accomplishable: false),
        QuestModel(id: "", title: "등산하기", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 28, accomplishable: false),
        QuestModel(id: "", title: "스트레칭하기", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 51, accomplishable: false),
        QuestModel(id: "", title: "스쿼트하기", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 42, accomplishable: false),
        QuestModel(id: "", title: "노래듣기", term: .HOURLY, cycle: 1, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 13, accomplishable: false),
        QuestModel(id: "", title: "알림 확인하기", term: .HOURLY, cycle: 12, startTime: "09:00", endTime: "12:00", days: [.MONDAY, .WEDNESDAY], deadline: 50, totalAlarmCount: 12, accomplishCount: 15, accomplishable: false)
    ]
    
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
        register()
        layout()
        addPlaceHolder()
        habitNameTextField.delegate = self
        habitIDTextField.delegate = self
    }
    
    override func keyboardWillAppear(_ notification: Notification) {
        let frame = halfContainerView.halfView.frame
        halfViewOriginFrame = frame
        let newFrame = CGRect(x: frame.minX, y: frame.minY - 280, width: frame.width, height: frame.height)
        UIView.animate(withDuration: 0.24, animations: {
            self.halfContainerView.halfView.frame = newFrame
        })
    }
    
    override func keyboardWillDisappear(_ notification: Notification) {
        UIView.animate(withDuration: 0.24, animations: {
            self.halfContainerView.halfView.frame = self.halfViewOriginFrame ?? .zero
        })
    }
}

// MARK: - Extensions

extension AddHabitMainViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .homeBackground
        view.add(containerView)
        
        containerView.adds(
            [
                navigationView,
                titleLabel,
                habitNameTextField,
                applyByIDButton,
                habitSuggestionTitleLabel,
                firstSuggestionCollectionView,
                secondSuggestionCollectionView,
                joinHabitTitleLabel,
                joinExistingHabitCollectionView
            ]
        )
        
        halfView.adds([halfViewTitleLabel, habitIDTitleLabel, habitIDTextField, halfViewButton])
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(64.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationView.snp.bottom).offset(24.adjusted)
            $0.leading.equalToSuperview().offset(27.adjusted)
        }
        
        habitNameTextField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24.adjusted)
            $0.leading.equalToSuperview().offset(15.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40.adjusted)
        }
        
        applyByIDButton.snp.makeConstraints {
            $0.top.equalTo(self.habitNameTextField.snp.bottom).offset(12.adjusted)
            $0.leading.equalTo(self.titleLabel)
            $0.width.equalTo(100.adjusted)
            $0.height.equalTo(20.adjusted)
        }
        
        habitSuggestionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.applyByIDButton.snp.bottom).offset(152.adjusted)
            $0.leading.equalTo(self.titleLabel)
        }
        
        let firstCount = socialModel.count/2
        
        firstSuggestionCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.habitSuggestionTitleLabel.snp.bottom).offset(12.adjusted)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(69.adjusted)
            $0.width.equalTo(CGFloat(firstCount) * 120 + 80 - 8)
        }
        
        let secondCount = socialModel.count - firstCount
        
        secondSuggestionCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.firstSuggestionCollectionView.snp.bottom).offset(4.adjusted)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(69.adjusted)
            $0.width.equalTo(CGFloat(secondCount) * 120 + 40 - 8)
        }
        
        joinHabitTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.secondSuggestionCollectionView.snp.bottom).offset(32.adjusted)
            $0.leading.equalTo(self.titleLabel)
        }
        
        let joinCount = socialModel.count
        
        joinExistingHabitCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.joinHabitTitleLabel.snp.bottom).offset(12.adjusted)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(120.adjusted)
            $0.width.equalTo(CGFloat(joinCount) * 238 + 30 - 12)
            $0.bottom.equalToSuperview().offset(42.adjusted)
        }
        
        halfViewTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(28.adjusted)
        }
        
        habitIDTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.halfViewTitleLabel.snp.bottom).offset(30.adjusted)
            $0.leading.equalToSuperview().offset(28.adjusted)
        }
        
        habitIDTextField.snp.makeConstraints {
            $0.top.equalTo(self.habitIDTitleLabel.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview().offset(15.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40.adjusted)
        }
        
        halfViewButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-34.adjusted)
            $0.leading.equalToSuperview().offset(14.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(56.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        firstSuggestionCollectionView.register(
            HabitSuggestionCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitSuggestionCollectionViewCell.identifier
        )
        
        secondSuggestionCollectionView.register(
            HabitSuggestionCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitSuggestionCollectionViewCell.identifier
        )
        
        joinExistingHabitCollectionView.register(
            JoinExistingHabitCollectionViewCell.self,
            forCellWithReuseIdentifier: JoinExistingHabitCollectionViewCell.identifier
        )
        
        firstSuggestionCollectionView.delegate = self
        firstSuggestionCollectionView.dataSource = self
        
        secondSuggestionCollectionView.delegate = self
        secondSuggestionCollectionView.dataSource = self
        
        joinExistingHabitCollectionView.delegate = self
        joinExistingHabitCollectionView.dataSource = self
    }
    
    private func addPlaceHolder() {
        let placeholder = NSAttributedString(
            string: "습관 이름 입력",
            attributes: [
                .foregroundColor: UIColor.brownGrey, .
                font: UIFont.SFTextRegular(fontSize: 13.adjusted)
            ]
        )
        
        habitNameTextField.attributedPlaceholder = placeholder
    }
    
    private func addHalfViewPlaceHolder() {
        let placeholder = NSAttributedString(
            string: "8자리 ID를 입력하세요.",
            attributes: [
                .foregroundColor: UIColor.brownGrey, .
                font: UIFont.SFTextRegular(fontSize: 13.adjusted)
            ]
        )
        
        habitIDTextField.attributedPlaceholder = placeholder
    }
    
    private func pushToAddHabitSecondViewController(name: String) {
        let secondVC = AddHabitSecondViewController()
        secondVC.configTitle(name: name, isDetail: false)
        secondVC.rootViewController = rootViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func pushToAddHabitSecondViewController(name: String, model: QuestModel) {
        let secondVC = AddHabitSecondViewController()
        secondVC.configTitle(name: name, isDetail: false)
        secondVC.rootViewController = rootViewController
        var requestModel = QuestRequestModel.init(model: model)
        secondVC.habitModel = requestModel
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    private func pushToSecondWithID(model: QuestRequestModel) {
        let secondVC = AddHabitSecondViewController()
        secondVC.configTitle(name: model.title, isDetail: false)
        secondVC.rootViewController = rootViewController
        secondVC.habitModel = model
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchUpByIDButton() {
        addHalfViewPlaceHolder()
        halfViewButton.addTarget(self, action: #selector(touchUpHalfViewButton), for: .touchUpInside)
        halfContainerView.appearHalfView(subView: halfView, 300.adjusted)
    }
    
    @objc
    private func touchUpHalfViewButton() {
        halfContainerView.dissmissFromSuperview()
        if let model = habitModelWithID {
            pushToSecondWithID(model: model)
        }
    }
    
    // MARK: - Action Helpers
    
    func fetchQuestWithID(questID: String) {
        networkService.fetchQuestWithID(questID: questID)
            .subscribe(onNext: { response in
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(QuestModel.self, from: response.data)
                        let requestModel = QuestRequestModel.init(model: data)
                        self.habitModelWithID = requestModel
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

extension AddHabitMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == joinExistingHabitCollectionView {
            return CGSize(width: 226.adjusted, height: 120.adjusted)
        }
        return CGSize(width: 112.adjusted, height: 61.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == joinExistingHabitCollectionView {
            return 12.adjusted
        }
        return 8.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case firstSuggestionCollectionView:
            return UIEdgeInsets(top: 4.adjusted, left: 40.adjusted, bottom: 4.adjusted, right: 40.adjusted)
        case secondSuggestionCollectionView:
            return UIEdgeInsets(top: 4.adjusted, left: 10.adjusted, bottom: 4.adjusted, right: 40.adjusted)
        case joinExistingHabitCollectionView:
            return UIEdgeInsets(top: 0.adjusted, left: 15.adjusted, bottom: 0.adjusted, right: 15.adjusted)
        default:
            return .zero
        }
    }
}

// MARK: - UICollectionViewDataSource

extension AddHabitMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let firstCount: Int = socialModel.count/2
        switch collectionView {
        case firstSuggestionCollectionView:
            return firstCount
            
        case secondSuggestionCollectionView:
            return socialModel.count - firstCount
            
        case joinExistingHabitCollectionView:
            return habitModel.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case firstSuggestionCollectionView:
            guard let habitCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitSuggestionCollectionViewCell.identifier, for: indexPath)
                    as? HabitSuggestionCollectionViewCell else { return UICollectionViewCell() }
            
            habitCell.dataBind(model: socialModel[indexPath.item])
            habitCell.contentView.setRounded(radius: 12.adjusted)
            return habitCell
            
        case secondSuggestionCollectionView:
            guard let habitCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitSuggestionCollectionViewCell.identifier, for: indexPath)
                    as? HabitSuggestionCollectionViewCell else { return UICollectionViewCell() }
            
            let index = indexPath.item + socialModel.count/2
            habitCell.dataBind(model: socialModel[index])
            return habitCell
            
        case joinExistingHabitCollectionView:
            guard let habitCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: JoinExistingHabitCollectionViewCell.identifier, for: indexPath)
                    as? JoinExistingHabitCollectionViewCell else { return UICollectionViewCell() }
            
            habitCell.dataBind(model: habitModel[indexPath.item])
            return habitCell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == joinExistingHabitCollectionView {
            pushToAddHabitSecondViewController(
                name: habitModel[indexPath.item].title,
                model: habitModel[indexPath.item]
            )
        }
    }
}

// MARK: - UITextFieldDelegate

extension AddHabitMainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == habitNameTextField {
            if let text = textField.text {
                pushToAddHabitSecondViewController(name: text)
            }
            return true
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == habitIDTextField {

        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == habitIDTextField {
          
        }
    }
}
