//
//  HomeCollectionFlowLayout.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 23/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

class HomeCollectionFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 220
    var itemWidth: CGFloat = Constant.Size.screenWidth
    
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
        minimumLineSpacing = 16
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
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
