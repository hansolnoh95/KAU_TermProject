//
//  IntiialViewController.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - InitialViewController

final class InitialViewController: BaseViewController {

    // MARK: - Components
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "homeLogo")
    }
    
    private let logoTitleView = UILabel().then {
        $0.setupLabel(text: "HABIT", color: .lightishBlue, font: .boldSystemFont(ofSize: 43.adjusted))
    }
    
    private let signupButton = UIButton().then {
        $0.setupButton(
            title: "회원가입",
            color: .homeBackground,
            font: .SFTextBold(fontSize: 16.adjusted),
            backgroundColor: .lightishBlue,
            state: .normal,
            radius: 26.adjusted
        )
        $0.addTarget(self, action: #selector(touchUpSignupButton), for: .touchUpInside)
    }
   
    private let loginButton = UIButton().then {
        $0.setupButton(
            title: "로그인",
            color: .lightishBlue,
            font: .SFTextBold(fontSize: 16.adjusted),
            backgroundColor: .clear,
            state: .normal,
            radius: 26.adjusted
        )
        $0.addTarget(self, action: #selector(touchUpLoginButton), for: .touchUpInside)
    }
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
}

// MARK: - Extensions

extension InitialViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.adds(
            [
                logoImageView,
                logoTitleView,
                signupButton,
                loginButton
            ]
        )
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(168.adjusted)
            $0.width.equalTo(160.adjusted)
            $0.height.equalTo(160.adjusted)
        }
        
        logoTitleView.snp.makeConstraints {
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(10.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-62.adjusted)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(23.adjusted)
            $0.height.equalTo(52.adjusted)
        }
        
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(self.loginButton.snp.top).offset(-1.adjusted)
            $0.leading.trailing.equalTo(self.loginButton)
            $0.height.equalTo(52.adjusted)
            $0.top.greaterThanOrEqualTo(self.logoImageView).offset(156.5.adjusted)
        }
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchUpLoginButton() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc
    private func touchUpSignupButton() {
        let codeVC = SignupViewController()
        self.present(codeVC, animated: true, completion: nil)
    }
}
