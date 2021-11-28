//
//  UnderLinedTextField.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import Foundation
import UIKit

// MARK: - UnderLinedTextField

class UnderLinedTextField : FourInsetTextField {
    
    override init(insets: UIEdgeInsets) {
        super.init(insets: insets)
        self.borderStyle = .none
        self.setRounded(radius: 8)
        self.font = .SFTextMedium(fontSize: 16.adjusted)
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not intended for use from a NIB")
    }
}

// MARK: - Extensions

extension UnderLinedTextField {
    
    // MARK: - General Helpers
    
    func addUnderLine (color: UIColor) {
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height, width: self.bounds.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
    
        self.clipsToBounds = false
        self.layer.addSublayer(bottomLine)
    }
}

extension UnderLinedTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.sublayers?.removeAll()
        self.addUnderLine(color: .lightishBlue)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !self.hasText {
            self.layer.sublayers?.removeAll()
            self.addUnderLine(color: .systemGray4)
        }
    }
}


