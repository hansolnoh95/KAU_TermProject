//
//  CustomTextView.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

// MARK: - CustomTextView

class CustomTextView: UITextView {

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame,textContainer: textContainer)
    self.borderWidth = 1
    self.borderColor = .gray
    self.setRounded(radius: 8)
    self.font = .SFTextLight(fontSize: 16)
    self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    self.enablesReturnKeyAutomatically = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

