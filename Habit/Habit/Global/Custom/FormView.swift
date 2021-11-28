//
//  FormView.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - FormView

final class FormView: UIView {
    
    // MARK: - Components
    
    private let titleLabel = UILabel()
    private let vitalLabel = UILabel()
    let formTextField = UnderLinedTextField(
        insets: UIEdgeInsets(top: 0, left: 0, bottom: 3.adjusted, right: 0)).then {
            $0.font = .SFTextMedium(fontSize: 20.adjusted)
            $0.textColor = .black
            $0.clearsOnBeginEditing = true
        }
    let descriptionLabel = UILabel()
    
    // MARK: - Variables
    
    var isVital = false
    var isInit = true
    
    // MARK: - LifeCycles
    
    init(frame: CGRect, isVital: Bool) {
        super.init(frame: frame)
        self.isVital = isVital
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if isInit {
            formTextField.layer.sublayers?.removeAll()
            formTextField.addUnderLine(color: .systemGray4)
            isInit = false
        }
    }
}

// MARK: - Extensions

extension FormView {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        self.adds(
            [
                titleLabel,
                vitalLabel,
                formTextField,
                descriptionLabel
            ]
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        vitalLabel.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(2.adjusted)
            $0.centerY.equalTo(self.titleLabel)
        }
        
        formTextField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(14.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(29.adjusted)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.formTextField.snp.bottom).offset(8.adjusted)
            $0.leading.equalToSuperview()
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(title: String) {
        titleLabel.setupLabel(text: title, color: .black, font: .SFTextMedium(fontSize: 14.adjusted))
        if isVital {
            vitalLabel.setupLabel(
                text: "*",
                color: .red,
                font: .SFTextMedium(fontSize: 14.adjusted)
            )
        }
    }
    
    func showGreenText(description: String) {
        self.snp.updateConstraints {
            $0.height.equalTo(84.adjusted)
        }
        formTextField.layer.sublayers?.removeAll()
        formTextField.addUnderLine(color: .lightishBlue)
        descriptionLabel.isHidden = false
        descriptionLabel.setupLabel(
            text: description,
            color: .lightishBlue,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
    }
    
    func showRedText(description: String) {
        self.snp.updateConstraints {
            $0.height.equalTo(84.adjusted)
        }
        formTextField.layer.sublayers?.removeAll()
        formTextField.addUnderLine(color: .systemRed)
        formTextField.shake()
        descriptionLabel.isHidden = false
        descriptionLabel.setupLabel(
            text: description,
            color: .systemRed,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
    }
}

