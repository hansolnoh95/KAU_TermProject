//
//  UIView+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

// MARK: - UIView Extension

extension UIView {
    
    // MARK: - IBInspectable
    
    @IBInspectable
    var ibCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = newValue
        }
    }
    
    
    func addUnderBar() {
        let underBar = UIView().then{
            $0.backgroundColor = .gray
        }
        self.add(underBar)
        underBar.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func addline(at : Direction) {
        let underBar = UIView().then{
            $0.backgroundColor = .gray
        }
        self.add(underBar)
        
        switch at {
        case .top:
            underBar.snp.makeConstraints{
                $0.leading.trailing.top.equalToSuperview()
                $0.height.equalTo(1)
            }
        case .leading:
            underBar.snp.makeConstraints{
                $0.top.leading.bottom.equalToSuperview()
                $0.width.equalTo(1)
            }
        case .trailing:
            underBar.snp.makeConstraints{
                $0.top.trailing.bottom.equalToSuperview()
                $0.width.equalTo(1)
            }
        case .bottom:
            underBar.snp.makeConstraints{
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
    }
    
    @discardableResult
    func add<T: UIView>(_ subview: T, then closure: ((T) -> Void)? = nil) -> T {
        addSubview(subview)
        closure?(subview)
        return subview
    }
    
    @discardableResult
    func adds<T: UIView>(_ subviews: [T], then closure: (([T]) -> Void)? = nil) -> [T] {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
        return subviews
    }
    
    func setRounded(radius : CGFloat?){
        /// UIView 의 모서리가 둥근 정도를 설정
        if let cornerRadius_ = radius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            /// cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    func setBorder(borderColor : UIColor?, borderWidth : CGFloat?) {
        /// UIView 의 테두리 색상 설정
        if let borderColor_ = borderColor {
            self.layer.borderColor = borderColor_.cgColor
        } else {
            /// borderColor 변수가 nil 일 경우의 default
            self.layer.borderColor = UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0).cgColor
        }
        /// UIView 의 테두리 두께 설정
        if let borderWidth_ = borderWidth {
            self.layer.borderWidth = borderWidth_
        } else {
            /// borderWidth 변수가 nil 일 경우의 default
            self.layer.borderWidth = 1.0
        }
    }
}
