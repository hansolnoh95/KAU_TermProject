//
//  SocialCollectionViewCell.swift
//  Habit
//
//  Created by 노한솔 on 2021/10/02.
//

import UIKit

import SnapKit
import Then

// MARK: - SocialCollectionViewCell

final class SocialCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    
    private let socialProfileImageView = UIImageView().then {
        $0.backgroundColor = .lightBlueGrey
    }
    
    private let socialProfileNameLabel  = UILabel()
    private let socialMessageLabel = UILabel().then {
        $0.numberOfLines = 2
    }
    
    // MARK: - Variables
    
    
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

extension SocialCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        self.setRounded(radius: 12.adjusted)
        
        contentView.adds([socialProfileImageView, socialProfileNameLabel, socialMessageLabel])
        
        socialProfileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.adjusted)
            $0.leading.equalToSuperview().offset(12.adjusted)
            $0.width.height.equalTo(32.adjusted)
        }
        
        socialMessageLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-11.adjusted)
            $0.leading.equalToSuperview().offset(12.adjusted)
            $0.trailing.equalToSuperview().offset(-12.adjusted)
        }
        
        socialProfileNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.socialMessageLabel.snp.top).offset(-4.adjusted)
            $0.leading.equalToSuperview().offset(12.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(backgroundColor: UIColor, profileImage: String, name: String, message: String) {
        contentView.backgroundColor = backgroundColor
        socialProfileImageView.image = UIImage(named: profileImage)
        socialProfileNameLabel.setupLabel(
            text: name,
            color: .white.withAlphaComponent(0.6),
            font: .SFTextSemibold(fontSize: 11.adjusted)
        )
        
        socialMessageLabel.setupLabel(
            text: message,
            color: .white,
            font: .SFTextSemibold(fontSize: 11.adjusted)
        )
    }
}
