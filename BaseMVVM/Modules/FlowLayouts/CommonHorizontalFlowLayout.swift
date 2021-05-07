//
//  CommonHorizontalFlowLayout.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 23/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

class CommonHorizontalFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 220
    var itemWidth: CGFloat = 128
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init()
        setupLayout()
    }
    
    private func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 8
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    override var itemSize: CGSize {
        set {
            itemHeight = newValue.height
            itemWidth = newValue.width
        }
        get {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

