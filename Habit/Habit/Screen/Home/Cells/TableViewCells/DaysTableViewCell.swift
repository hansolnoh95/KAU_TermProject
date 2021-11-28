//
//  DaysTableViewCell.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import UIKit

import SnapKit
import Then

// MARK: - DaysTableViewCell

final class DaysTableViewCell: UITableViewCell {

    // MARK: - Components
    
    private var dayLabel = UILabel()
    private var isSelectIcon = UIImageView().then {
        $0.isHidden = true
        $0.image = UIImage(named: "btnCheck")
    }
    
    // MARK: - Variables
    
    var index: Int?
    var rootView: UIView?
    
    // MARK: - LifeCycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: DaysTableViewCell.identifier)
        layout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelectIcon.isHidden = true
        dayLabel.text = ""
    }
    
}

// MARK: - Extensions

extension DaysTableViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.adds([dayLabel, isSelectIcon])
        
        dayLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        isSelectIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20.adjusted)
            $0.width.height.equalTo(20.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(title: String, isSelect: Bool) {
        dayLabel.setupLabel(text: title, color: .black, font: .SFTextMedium(fontSize: 14.adjusted))
        if isSelect {
            isSelectIcon.isHidden = false
        } else {
            isSelectIcon.isHidden = true
        }
    }
}
