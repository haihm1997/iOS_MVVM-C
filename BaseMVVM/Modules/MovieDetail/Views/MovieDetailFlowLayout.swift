//
//  MovieDetailFlowLayout.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 06/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

class MovieDetailFlowLayout: UICollectionViewFlowLayout {
    
    var itemWidth: CGFloat = Constant.Size.screenWidth - 16
    var itemHeight: CGFloat = 150
    
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
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 24, right: 8)
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
