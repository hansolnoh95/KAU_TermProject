//
//  TextAttribute.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/03.
//

import Foundation
import UIKit

import Then

struct TextAttribute {
    
    static func titleLabelAttribute() -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle().then {
            $0.lineSpacing = 3.adjusted
            $0.alignment = .left
        }
        return [
            .foregroundColor: UIColor.black,
            .font: UIFont.SFTextBold(fontSize: 24.adjusted),
            .paragraphStyle: paragraphStyle
        ]
    }
    
    static func placeholderAttribute() -> [NSAttributedString.Key: Any] {
        return [
            .foregroundColor: UIColor.black,
            .font: UIFont.SFTextMedium(fontSize: 16.adjusted)
        ]
    }
    
    static func underlinedPlaceholderAttribute() -> [NSAttributedString.Key: Any] {
        return [
            .foregroundColor: UIColor.black,
            .font: UIFont.SFTextMedium(fontSize: 16.adjusted),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.gray,
        ]
    }
    
    static func subtitleAttribute() -> [NSAttributedString.Key: Any] {
        return [
            .foregroundColor: UIColor.black,
            .font: UIFont.SFTextRegular(fontSize: 12.adjusted),
        ]
    }
}
