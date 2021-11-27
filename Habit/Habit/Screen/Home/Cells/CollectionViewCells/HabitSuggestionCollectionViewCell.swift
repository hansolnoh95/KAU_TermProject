//
//  HabitSuggestionCollectionViewCell.swift
//  Habit
//
//  Created by 노한솔 on 2021/10/26.
//

import UIKit

import SnapKit
import Then

// MARK: - HabitSuggestionCollectionViewCell
final class HabitSuggestionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    
    private let titleLabel = UILabel()
    private let periodLabel = UILabel()
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension HabitSuggestionCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        contentView.setRounded(radius: 12.adjusted)
        
        contentView.adds(
            [
                titleLabel,
                periodLabel
            ]
        )
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12.adjusted)
        }
        
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(6.adjusted)
            $0.leading.equalTo(self.titleLabel)
        }
        
    }
    
    // MARK: - General Helpers
    
    func dataBind(model: SimpleSocial) {
        contentView.backgroundColor = model.backgroundColor
        titleLabel.setupLabel(
            text: "물 2리터 마시기",
            color: .white,
            font: .SFTextSemibold(fontSize: 13.adjusted)
        )
        
        periodLabel.setupLabel(
            text: "매일",
            color: .white.withAlphaComponent(0.6),
            font: .SFTextSemibold(fontSize: 11.adjusted)
        )
    }
}
