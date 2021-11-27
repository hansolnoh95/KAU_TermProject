//
//  CustomTextField.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

// MARK: - CustomTextField

class CustomTextField : FourInsetTextField {
    
    override init(insets: UIEdgeInsets) {
        super.init(insets: insets)
        self.borderWidth = 1
        self.borderColor = .gray
        self.setRounded(radius: 8)
        self.font = .SFTextMedium(fontSize: 16)
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not intended for use from a NIB")
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
}
