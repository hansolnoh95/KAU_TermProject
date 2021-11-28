//
//  CustomNavigationBar.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit

// MARK: - CustomNavigationBar

class CustomNavigationBar : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpNavi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backBtn = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let rightButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    let naviTitle = UILabel().then{
        $0.font = .SFTextMedium(fontSize: 18)
    }
    
    private func setUpNavi() {
        self.backgroundColor = .white
        self.adds([naviTitle, backBtn, rightButton])
        
        naviTitle.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-13.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-13.adjusted)
            $0.width.height.equalTo(24.adjusted)
            $0.leading.equalToSuperview().offset(21.adjusted)
        }
        
        rightButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-13.adjusted)
            $0.width.height.equalTo(24.adjusted)
            $0.trailing.equalToSuperview().offset(-21.adjusted)
        }
        
        backBtn.addAction( for: .touchUpInside, closure: { _ in
            UIApplication.shared.topViewController()?.popViewController()
        })
    }
    
    func setUp(
        title: String,
        font: UIFont = .SFTextMedium(fontSize: 18),
        titleColor: UIColor = .black,
        leftBtn: Bool = true,
        rightBtn : String?) {
        
        self.naviTitle.text = title
        self.naviTitle.font = font
        self.naviTitle.textColor = titleColor
        
        if !leftBtn {
            self.backBtn.removeFromSuperview()
        }
        
        if let right = rightBtn {
            self.rightButton.setBackgroundImage(UIImage(named: right), for: .normal)
        } else {
            self.rightButton.isHidden = true
        }
    }
}


