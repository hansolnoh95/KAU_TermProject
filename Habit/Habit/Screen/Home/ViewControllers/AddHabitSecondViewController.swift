//
//  AddHabitSecondViewController.swift
//  Habit
//
//  Created by 노한솔 on 2021/10/26.
//

import UIKit

import Moya
import RxSwift
import SnapKit
import Then

// MARK: - AddHabitSecondViewController

final class AddHabitSecondViewController: BaseViewController {
    
    // MARK: - Lazy Components
    
    private lazy var optionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsVerticalScrollIndicator = false
        }
        
        return collectionView
    }()
    
    // MARK: - Components
    
    private let navigationView = CustomNavigationBar().then {
        $0.setUp(title: "습관 추가", rightBtn: "")
        $0.backBtn.setBackgroundImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    private let habitNameTitleLabel = UILabel().then {
        $0.setupLabel(text: "습관 이름", color: .brownGrey, font: .SFTextMedium(fontSize: 12.adjusted))
    }
    
    private let habitNameContentLabel = UILabel()
    private let habitIDLabel = UILabel().then {
        $0.isUserInteractionEnabled = true
        $0.isEnabled = true
    }
    
    private let peopleCountTitleLabel = UILabel().then {
        $0.setupLabel(text: "참가자 수", color: .brownGrey, font: .SFTextMedium(fontSize: 12.adjusted))
    }
    
    private let aloneButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "btnAlone"), for: .normal)
    }
    
    private let isPublicTitleLabel = UILabel().then {
        $0.setupLabel(text: "공개 범위", color: .brownGrey, font: .SFTextMedium(fontSize: 12.adjusted))
    }
    
    private let publicButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "btnPublic"), for: .normal)
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .brownGrey.withAlphaComponent(0.5)
    }
    
    private let informLabel = UILabel()
    
    private let nextButton = UIButton().then {
        $0.setupButton(
            title: "완료",
            color: .white,
            font: .SFTextSemibold(fontSize: 15.adjusted),
            backgroundColor: .lightishBlue,
            state: .normal,
            radius: 16.adjusted
        )
        $0.addTarget(self, action: #selector(touchupConfirmButton), for: .touchUpInside)
    }
    
    private let pickerPopupView = PopUpView()
    private let pickerView = UIPickerView().then {
        $0.tag = 0
    }
    
    private let dayContainerView = HalfAppearView()
    private let dayView = SelectDaysView()
    
    // MARK: - Variables
    
    private let networkService = NetworkService(
        provider: MoyaProvider<NetworkRouter>(
            plugins: [NetworkLoggerPlugin(verbose: true)]
        )
    )
    
    var habitModel = QuestRequestModel.init()
    var rootViewController: UIViewController?
    
    var cycles = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var days: [Days] = [.MONDAY, .TUESDAY, .WEDNESDAY, .THURSDAY, .FRIDAY, .SATURDAY, .SUNDAY]
    var deadliens = [10, 20, 30, 40, 50]
    var hours = Array<Int>(1...23)
    var minutes = Array<Int>(0...59)
    var hourString = "00"
    var minuteString = "00"
    var habitID: String?
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        configDelegate()
        layout()
        addGesture()
    }
}

// MARK: - Extensions

extension AddHabitSecondViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.adds(
            [
                navigationView,
                habitNameTitleLabel,
                habitNameContentLabel,
                habitIDLabel,
                peopleCountTitleLabel,
                aloneButton,
                isPublicTitleLabel,
                publicButton,
                separatorView,
                optionCollectionView,
                nextButton,
                informLabel
            ]
        )
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(64.adjusted)
        }
        
        habitNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationView.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview().offset(28.adjusted)
        }
        
        habitNameContentLabel.snp.makeConstraints {
            $0.top.equalTo(self.habitNameTitleLabel.snp.bottom).offset(4.adjusted)
            $0.leading.equalTo(self.habitNameTitleLabel)
            $0.width.equalTo(215.adjusted)
        }
        
        habitIDLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.habitNameContentLabel)
            $0.trailing.equalToSuperview().offset(-16.adjusted)
        }
        
        peopleCountTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.habitNameContentLabel.snp.bottom).offset(44.adjusted)
            $0.leading.equalTo(self.habitNameTitleLabel)
        }
        
        aloneButton.snp.makeConstraints {
            $0.centerY.equalTo(self.peopleCountTitleLabel)
            $0.trailing.equalToSuperview().offset(-16.adjusted)
            $0.width.equalTo(87.adjusted)
            $0.height.equalTo(40.adjusted)
        }
        
        isPublicTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.peopleCountTitleLabel.snp.bottom).offset(40.adjusted)
            $0.leading.equalTo(self.habitNameTitleLabel)
        }
        
        publicButton.snp.makeConstraints {
            $0.centerY.equalTo(self.isPublicTitleLabel)
            $0.trailing.equalTo(aloneButton)
            $0.width.equalTo(87.adjusted)
            $0.height.equalTo(40.adjusted)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(self.isPublicTitleLabel.snp.bottom).offset(40.adjusted)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-34.adjusted)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(348.adjusted)
            $0.height.equalTo(56.adjusted)
        }
        
        informLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.nextButton.snp.top).offset(-20.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        optionCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.separatorView.snp.bottom).offset(19.adjusted)
            $0.leading.trailing.equalToSuperview().inset(16.adjusted)
            $0.height.equalTo(6*36.adjusted + 5*8.adjusted + 10.adjusted)
            //            $0.bottom.greaterThanOrEqualTo(self.informLabel.snp.top).offset(50.adjusted).priority(150)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        optionCollectionView.register(
            OptionCollectionViewCell.self,
            forCellWithReuseIdentifier: OptionCollectionViewCell.identifier
        )
    }
    
    private func configDelegate() {
        optionCollectionView.delegate = self
        optionCollectionView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func configTitle(name: String, isDetail: Bool) {
        habitNameContentLabel.setupLabel(text: name, color: .black, font: .SFTextSemibold(fontSize: 20.adjusted))
        if isDetail {
            navigationView.naviTitle.text = "습관 상세"
            optionCollectionView.isUserInteractionEnabled = false
            nextButton.isHidden = true
        } else {
            navigationView.naviTitle.text = "습관 추가"
        }
        
        if let ID = habitID {
            habitIDLabel.setupLabel(text: "id: \(ID)", color: .brownGrey, font: .SFTextRegular(fontSize: 12.adjusted))
        }
    }
    
    private func addGesture() {
        let gesture = UILongPressGestureRecognizer().then {
            $0.numberOfTapsRequired = 0
            $0.numberOfTouchesRequired = 1
            $0.minimumPressDuration = 2
        }
        gesture.addTarget(self, action: #selector(longPressedIDLabel))
        habitIDLabel.addGestureRecognizer(gesture)
    }
    
    private func convertMinute(minute: Int) -> String {
        if minute/60 == 0 {
            return "\(minute%60)분"
        }
        else if minute%60 == 0 {
            return "\(minute/60)시간"
        }
        else {
            return "\(minute/60)시간 \(minute%60)분"
        }
    }
    
    private func configPickerView(index: Int) {
        pickerView.tag = index
        pickerView.reloadAllComponents()
        pickerPopupView.appearPopUpView(
            subView: pickerView)
    }
    
    private func configDayContainerView() {
        dayView.rootViewController = self
        dayContainerView.appearHalfView(subView: dayView, 400.adjusted)
    }
    
    func reloadCollectionView() {
        optionCollectionView.reloadData()
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchupConfirmButton() {
        if let title = habitNameContentLabel.text {
            habitModel.title = title
        }
        print(habitModel)
        createQuest()
    }
    
    @objc
    private func longPressedIDLabel() {
        if let ID = habitID {
            UIPasteboard.general.string = ID
        }
    }
    
    // MARK: - Server Helpers
    
    private func createQuest() {
        networkService.createQuest(param: habitModel)
            .subscribe(onNext: { response in
                if response.statusCode == 201 {
                    do {
                        print("success")
                        if let rootVC = self.rootViewController as? HomeViewController {
                            rootVC.fetchQuest()
                        }
                        self.popToRootViewController()
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

extension AddHabitSecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32.adjusted
        return CGSize(width: width, height: 36.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10.adjusted, right: 0)
    }
}

// MARK: - UICollectionViewDataSource

extension AddHabitSecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let optionCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OptionCollectionViewCell.identifier, for: indexPath)
                as? OptionCollectionViewCell else { return UICollectionViewCell() }
        
        optionCell.initialDataBind(index: indexPath.item)
        
        switch indexPath.item {
        case 0:
            print("고정")
        case 1:
            if habitModel.cycle == 0 {
                optionCell.dataBind(content: "-", isChecked: false)
            } else {
                optionCell.dataBind(content: "\(habitModel.cycle)시간", isChecked: true)
            }
            
        case 2:
            optionCell.dataBind(content: habitModel.startTime, isChecked: false)
            if habitModel.startTime != "00:00" {
                optionCell.unitContentLabel.textColor = .lightishBlue
                optionCell.nextLabel.textColor = .skyBlue
            }
            
        case 3:
            optionCell.dataBind(content: habitModel.endTime, isChecked: false)
            if habitModel.endTime != "00:00" {
                optionCell.unitContentLabel.textColor = .lightishBlue
                optionCell.nextLabel.textColor = .skyBlue
            }
            
        case 4:
            var dayString = ""
            if habitModel.days == [] {
                optionCell.dataBind(content: "모든 요일", isChecked: false)
            }
            else if habitModel.days.count == 7 {
                optionCell.dataBind(content: "모든 요일", isChecked: true)
            }
            else {
                habitModel.days.sort(by: {$0 < $1})
                for days in habitModel.days {
                    dayString += "\(days.stringValue), "
                }
                dayString.removeLast(2)
                optionCell.dataBind(content: dayString, isChecked: true)
            }
            
        case 5:
            optionCell.dataBind(content: "\(habitModel.deadline)분", isChecked: false)
            if habitModel.deadline != 0 {
                optionCell.unitContentLabel.textColor = .lightishBlue
                optionCell.nextLabel.textColor = .skyBlue
            }
        default:
            print("error")
        }
        
        return optionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 || indexPath.item == 2 || indexPath.item == 3 || indexPath.item == 5 {
            configPickerView(index: indexPath.item)
        }
        if indexPath.item == 4 {
            configDayContainerView()
        }
    }
}

// MARK: - UIPickerViewDelegate

extension AddHabitSecondViewController: UIPickerViewDelegate {
    
}

// MARK: - UIPickerViewDataSource

extension AddHabitSecondViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 || pickerView.tag == 5 {
            return 1
        }
        else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return cycles.count
        }
        if pickerView.tag == 5 {
            return deadliens.count
        }
        else {
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(cycles[row])"
        }
        if pickerView.tag == 5 {
            return "\(deadliens[row])"
        }
        else {
            if component == 0 {
                return "\(hours[row])"
            } else {
                return "\(minutes[row])"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            habitModel.cycle = cycles[row]
            optionCollectionView.reloadData()
        }
        
        if pickerView.tag == 2 {
            if component == 0 {
                if hours[row] < 10 {
                    hourString = "0\(hours[row])"
                } else {
                    hourString = "\(hours[row])"
                }
            } else {
                if minutes[row] < 10 {
                    minuteString = "0\(minutes[row])"
                } else {
                    minuteString = "\(minutes[row])"
                }
            }
            habitModel.startTime = "\(hourString):\(minuteString)"
            optionCollectionView.reloadData()
        }
        
        if pickerView.tag == 3{
            if component == 0 {
                if hours[row] < 10 {
                    hourString = "0\(hours[row])"
                } else {
                    hourString = "\(hours[row])"
                }
            }
            if component == 1 {
                if minutes[row] < 10 {
                    minuteString = "0\(minutes[row])"
                } else {
                    minuteString = "\(minutes[row])"
                }
            }
            habitModel.endTime = "\(hourString):\(minuteString)"
            optionCollectionView.reloadData()
        }
        
        if pickerView.tag == 5 {
            habitModel.deadline = deadliens[row]
            optionCollectionView.reloadData()
        }
    }
    
}
