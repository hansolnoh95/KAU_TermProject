//
//  UIView+.swift
//  Finut
//
//  Created by λΈνμ on 2021/09/02.
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
        /// UIView μ λͺ¨μλ¦¬κ° λ₯κ·Ό μ λλ₯Ό μ€μ 
        if let cornerRadius_ = radius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            /// cornerRadius κ° nil μΌ κ²½μ°μ default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    func setBorder(borderColor : UIColor?, borderWidth : CGFloat?) {
        /// UIView μ νλλ¦¬ μμ μ€μ 
        if let borderColor_ = borderColor {
            self.layer.borderColor = borderColor_.cgColor
        } else {
            /// borderColor λ³μκ° nil μΌ κ²½μ°μ default
            self.layer.borderColor = UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0).cgColor
        }
        /// UIView μ νλλ¦¬ λκ» μ€μ 
        if let borderWidth_ = borderWidth {
            self.layer.borderWidth = borderWidth_
        } else {
            /// borderWidth λ³μκ° nil μΌ κ²½μ°μ default
            self.layer.borderWidth = 1.0
        }
    }
}
