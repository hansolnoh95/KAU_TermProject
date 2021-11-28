//
//  LoginViewController.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import UIKit

import Moya
import RxSwift
import SnapKit
import Then

// MARK: - LoginViewController

final class LoginViewController: BaseViewController {
    
    // MARK: - Components
    
    private let navigationView = CustomNavigationBar().then {
        $0.setUp(title: "", rightBtn: "")
        $0.backBtn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(
            string: "로그인",
            attributes:
                [
                    .font: UIFont.SFTextSemibold(fontSize: 22.adjusted),
                    .foregroundColor: UIColor.black,
                    .kern: -0.66
                ]
        )
    }
    
    private let emailView = FormView(frame: .zero, isVital: false)
    private let passwordView = FormView(frame: .zero, isVital: false)
    private let loginButton = UIButton().then {
        $0.setupButton(
            title: "로그인",
            color: .systemBackground,
            font: .SFTextSemibold(fontSize: 16.adjusted),
            backgroundColor: .lightishBlue,
            state: .normal,
            radius: 26.adjusted
        )
        $0.addTarget(self, action: #selector(touchUpLoginButton), for: .touchUpInside)
    }
    
    // MARK: - Variables
    
    private let networkService = NetworkService(
        provider: MoyaProvider<NetworkRouter>(
            plugins: [NetworkLoggerPlugin(verbose: true)]
        )
    )
    
    var loginModel: LoginRequestModel?
    var isInit = true
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        config()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isInit {
            emailView.formTextField.layer.sublayers?.removeAll()
            passwordView.formTextField.layer.sublayers?.removeAll()
            emailView.formTextField.addUnderLine(color: .systemGray4)
            passwordView.formTextField.addUnderLine(color: .systemGray4)
            isInit = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailView.formTextField.becomeFirstResponder()
    }
    
}

// MARK: - Extensions

extension LoginViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        
        view.adds(
            [
                navigationView,
                titleLabel,
                emailView,
                passwordView,
                loginButton
            ]
        )
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(60.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationView.snp.bottom).offset(16.adjusted)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(20.adjusted)
        }
        
        emailView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(30.adjusted)
            $0.leading.equalTo(self.titleLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60.adjusted)
        }
        
        passwordView.snp.makeConstraints {
            $0.top.equalTo(self.emailView.snp.bottom).offset(24.adjusted)
            $0.leading.equalTo(self.titleLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60.adjusted)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(self.passwordView.snp.bottom).offset(81.adjusted)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(23.adjusted)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func config() {
        emailView.dataBind(title: "이메일 ID")
        emailView.formTextField.keyboardType = .emailAddress
        emailView.formTextField.delegate = self
        
        passwordView.dataBind(title: "비밀번호")
        passwordView.formTextField.isSecureTextEntry = true
        passwordView.formTextField.delegate = self
    }
    
    private func login() {
        if let email = emailView.formTextField.text,
           let password = passwordView.formTextField.text {
            loginModel = LoginRequestModel(email: email, password: password)
        }
        
        if let model = loginModel {
            networkService.login(param: model)
                .subscribe(onNext: { response in
                    if response.statusCode == 200 {
                        do {
                            let decoder = JSONDecoder()
                            let data = try decoder.decode(LoginResponseModel.self, from: response.data)
                            UserDefaultHelper.set(data.accessToken, forKey: UserData.accessToken)
                            UserDefaultHelper.set(data.refreshToken, forKey: UserData.refreshToken)
                            self.presentHome()
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
    
    private func presentHome() {
        let naviVC = UINavigationController()
        let tabbarVC = HomeViewController()
        naviVC.addChild(tabbarVC)
        naviVC.navigationBar.isHidden = true
        naviVC.modalPresentationStyle = .fullScreen
        self.present(naviVC, animated: true, completion: nil)
    }
    
    // MARK: - Action Helpers
    @objc
    private func touchUpLoginButton() {
        emailView.formTextField.resignFirstResponder()
        passwordView.formTextField.resignFirstResponder()
        login()
    }
}


// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = textField as? UnderLinedTextField {
            field.layer.sublayers?.removeAll()
            field.addUnderLine(color: .lightishBlue)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let field = textField as? UnderLinedTextField {
            field.layer.sublayers?.removeAll()
            field.addUnderLine(color: .systemGray4)
        }
    }
}
