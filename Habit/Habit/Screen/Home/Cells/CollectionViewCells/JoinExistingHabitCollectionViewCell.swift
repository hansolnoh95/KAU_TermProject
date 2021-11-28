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
    
    private let habitNameLabel = UILabel()
    private let strikeImageView = UIImageView().then {
        $0.image = UIImage(named: "glitter")
    }
    
    private let strikeCountLabel = UILabel()
    private let termLabel = UILabel()
    private let peopleImageView = UIImageView().then {
        $0.image = UIImage(named: "peopleIcon")
    }
    
    private let peopleCountLabel = UILabel()
    
    private let profileImageView = UIImageView().then {
        $0.setRounded(radius: 8.adjusted)
        $0.backgroundColor = .homeBackground
        $0.borderColor = .black.withAlphaComponent(0.1)
        $0.borderWidth = 1
    }
    
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
        
        containerView.adds(
            [
                habitNameLabel,
                strikeImageView,
                strikeCountLabel,
                termLabel,
                peopleImageView,
                peopleCountLabel,
                profileImageView
            ]
        )
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        habitNameLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20.adjusted)
        }
        
        strikeImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.habitNameLabel)
            $0.leading.equalTo(self.habitNameLabel.snp.trailing).offset(3.adjusted)
            $0.width.height.equalTo(16.adjusted)
        }
        
        strikeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.habitNameLabel)
            $0.leading.equalTo(self.strikeImageView.snp.trailing).offset(2.adjusted)
        }
        
        termLabel.snp.makeConstraints {
            $0.top.equalTo(self.habitNameLabel.snp.bottom).offset(4.adjusted)
            $0.leading.equalTo(self.habitNameLabel)
        }
        
        peopleImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-21.adjusted)
            $0.leading.equalTo(self.habitNameLabel)
            $0.width.height.equalTo(14.adjusted)
        }
        
        peopleCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.peopleImageView)
            $0.leading.equalTo(self.peopleImageView.snp.trailing).offset(5.adjusted)
        }
        
        profileImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-17.adjusted)
            $0.centerY.equalTo(self.habitNameLabel)
            $0.height.width.equalTo(31.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(model: QuestModel) {
        habitNameLabel.setupLabel(
            text: model.title,
            color: .black,
            font: .SFTextSemibold(fontSize: 15.adjusted)
        )
        
        strikeCountLabel.setupLabel(
            text: "\(model.accomplishCount)",
            color: .brownishGrey,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
        
        let isPublicString: String = "공개"
        
        termLabel.setupLabel(
            text: "\(model.term.stringValue) · \(isPublicString)",
            color: .lightishBlue,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
        
        peopleCountLabel.setupLabel(
            text: "혼자",
            color: .brownGrey,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
        
    }
}
