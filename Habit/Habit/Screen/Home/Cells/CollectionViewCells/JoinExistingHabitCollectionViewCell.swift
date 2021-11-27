//
//  JoinExistingHabitCollectionViewCell.swift
//  Habit
//
//  Created by 노한솔 on 2021/10/26.
//

import UIKit

import SnapKit
import Then

// MARK: - JoinExistingHabitCollectionViewCell

final class JoinExistingHabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    
    private let containerView = UIView()
    
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

extension JoinExistingHabitCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        contentView.backgroundColor = .white
        contentView.setRounded(radius: 20.adjusted)
        
        contentView.add(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
