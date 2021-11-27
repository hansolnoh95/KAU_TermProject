//
//  HabitCollectionViewCell.swift
//  Habit
//
//  Created by 노한솔 on 2021/09/28.
//

import UIKit

import SnapKit
import Then

// MARK: - HabitCollectionViewCell

final class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    
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
    private let completeLabel = UILabel().then {
        $0.setupLabel(
            text: "<< 밀어서 완료하기",
            color: .lightishBlue,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
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

extension HabitCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        contentView.backgroundColor = .white
        contentView.setRounded(radius: 20.adjusted)
        
        contentView.adds(
            [
                habitNameLabel,
                strikeImageView,
                strikeCountLabel,
                termLabel,
                peopleImageView,
                peopleCountLabel,
                completeLabel
            ]
        )
        
        habitNameLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20.adjusted)
        }
        
        strikeImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.habitNameLabel)
            $0.leading.equalTo(self.habitNameLabel.snp.trailing).offset(10.adjusted)
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
        
        completeLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.peopleImageView)
            $0.trailing.equalToSuperview().offset(-19.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(model: Habit) {
        habitNameLabel.setupLabel(
            text: model.title,
            color: .black,
            font: .SFTextSemibold(fontSize: 15.adjusted)
        )
        
        strikeCountLabel.setupLabel(
            text: "\(model.strikes)",
            color: .brownishGrey,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
        
        let isPublicString: String = {
            model.isPublic ? "공개" : "비공개"
        }()
        termLabel.setupLabel(
            text: "\(model.term.rawValue) · \(isPublicString)",
            color: .lightishBlue,
            font: .SFTextMedium(fontSize: 12.adjusted)
        )
        
        if model.companies == 0 {
            peopleCountLabel.setupLabel(
                text: "혼자",
                color: .brownGrey,
                font: .SFTextMedium(fontSize: 12.adjusted)
            )
        }
        else {
            peopleCountLabel.setupLabel(
                text: "\(model.companies)",
                color: .brownGrey,
                font: .SFTextMedium(fontSize: 12.adjusted)
            )
        }
    }
}
