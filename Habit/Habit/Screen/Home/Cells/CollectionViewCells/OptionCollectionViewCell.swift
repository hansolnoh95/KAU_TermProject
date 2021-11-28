//
//  OptionCollectionViewCell.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - OptionCollectionViewCell

final class OptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    
    private let unitLabel = UILabel().then {
        $0.setupLabel(text: "주기 단위", color: .brownGrey, font: .SFTextMedium(fontSize: 12.adjusted))
    }
   
    let unitContentLabel = UILabel()
    let nextLabel = UILabel().then {
        $0.setupLabel(text: ">", color: .brownGrey, font: .SFTextBold(fontSize: 15.adjusted))
    }
    
    // MARK: - Variables
    
    var titles = ["주기 단위", "다음 시간마다", "시작 시간", "끝 시간", "요일", "활성 시간"]
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK - Extensions

extension OptionCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        contentView.backgroundColor = .clear
        contentView.adds([unitLabel, unitContentLabel, nextLabel])
        
        unitLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12.adjusted)
        }
        
        nextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20.adjusted)
        }
        unitContentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(self.nextLabel.snp.leading).offset(-12.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(content: String, isChecked: Bool) {
        unitContentLabel.setupLabel(text: content, color: .brownGrey, font: .SFTextMedium(fontSize: 15.adjusted))
        
        if isChecked {
            unitContentLabel.textColor = .lightishBlue
            nextLabel.textColor = .skyBlue
        } else {
            unitContentLabel.textColor = .brownGrey
            nextLabel.textColor = .brownGrey
        }
    }
    
    func initialDataBind(index: Int) {
        unitLabel.setupLabel(text: titles[index], color: .brownGrey, font: .SFTextMedium(fontSize: 12.adjusted))
        
        if index == 0 {
            unitContentLabel.setupLabel(text: "시간", color: .lightishBlue, font: .SFTextMedium(fontSize: 15.adjusted))
            nextLabel.textColor = .skyBlue
        }
    }
}
