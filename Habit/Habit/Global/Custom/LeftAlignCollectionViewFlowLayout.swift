//
//  LeftAlignCollectionViewFlowLayout.swift
//  Finut
//  LeftAlignCollectionViewFlowLayout.swift
//
//  Created by 노한솔 on 2021/09/23.
//

import UIKit

class LeftAlignCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 16.adjusted

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 16.adjusted
        self.sectionInset = .zero
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0.adjusted
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
