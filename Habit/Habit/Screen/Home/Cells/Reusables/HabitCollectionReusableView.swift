//
//  HabitCollectionReusableView.swift
//  Habit
//
//  Created by 노한솔 on 2021/09/28.
//

import UIKit

import SnapKit
import Then

// MARK: - HabitCollectionReusableView

final class HabitCollectionReusableView: UICollectionReusableView {
      
    // MARK: - Lazy Components
    
    private lazy var socialCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        return collectionView
    }()
    
    // MARK: - Components
    
    private let myHabitLabel = UILabel().then {
        $0.setupLabel(text: "내 습관", color: .black, font: .SFTextSemibold(fontSize: 15.adjusted))
    }
    
    // MARK: - Variables

    var socialModel: [SimpleSocial]?
    
    // MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        register()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension HabitCollectionReusableView {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        self.backgroundColor = .clear
        
        self.adds([socialCollectionView, myHabitLabel])
        
        socialCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120.adjusted)
        }
        
        myHabitLabel.snp.makeConstraints {
            $0.top.equalTo(self.socialCollectionView.snp.bottom).offset(24.adjusted)
            $0.leading.equalToSuperview().offset(28.adjusted)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        socialCollectionView.dataSource = self
        socialCollectionView.delegate = self
        
        socialCollectionView.register(
            SocialCollectionViewCell.self,
            forCellWithReuseIdentifier: SocialCollectionViewCell.identifier
        )
    }
    
    func reloadCollectionView() {
        socialCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HabitCollectionReusableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 97.adjusted, height: 112.adjusted)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.adjusted
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16.adjusted, bottom: 0, right: 16.adjusted)
    }
}

// MARK: - UICollectionViewDataSource

extension HabitCollectionReusableView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let socialCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SocialCollectionViewCell.identifier, for: indexPath)
                as? SocialCollectionViewCell else { return UICollectionViewCell() }
        
        if let modelList = socialModel {
            let model = modelList[indexPath.item]
            socialCell.dataBind(
                backgroundColor: model.backgroundColor,
                profileImage: model.imageName,
                name: model.name,
                message: model.message
            )
        }
        return socialCell
    }
    
    
}
