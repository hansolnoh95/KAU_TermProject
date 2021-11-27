//
//  UIViewController+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit
import RxSwift

// MARK: - UIViewController Extension

extension UIViewController {
    
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc
  func dismissVC() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc
  func popViewController() {
    self.navigationController?.popViewController(animated: true)
  }
    
  @objc
  func popToRootViewController() {
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  func setTabBarHidden(
    _ hidden: Bool,
    animated: Bool = true,
    duration: TimeInterval = 0.3) {
    
    if self.tabBarController?.tabBar.isHidden != hidden {
      if animated {
        /// Show the tabbar before the animation in case it has to appear
        if (self.tabBarController?.tabBar.isHidden)! {
          self.tabBarController?.tabBar.isHidden = hidden
        }
        
        if let frame = self.tabBarController?.tabBar.frame {
          let factor: CGFloat = hidden ? 1 : 0
          let y = frame.origin.y + (frame.size.height * factor)
          
          UIView.animate(withDuration: duration, animations: {
            self.tabBarController?.tabBar.frame =
                CGRect( x: frame.origin.x,
                        y: y,
                        width: frame.width,
                        height: frame.height)
          }) { (bool) in
            /// hide the tabbar after the animation in case ti has to be hidden
            if (!(self.tabBarController?.tabBar.isHidden)!) {
              self.tabBarController?.tabBar.isHidden = hidden
            }
          }
        }
      }
    }
  }
    
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
}

