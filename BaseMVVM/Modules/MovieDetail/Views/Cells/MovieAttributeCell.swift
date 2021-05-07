//
//  MovieAttributeCell.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 06/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import SnapKit

class MovieAttributeCell: BaseCollectionViewCell {
    
    let titleLabel = configure(UILabel()) {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    
    let siteLabel = configure(UILabel()) {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let typeLabel = configure(UILabel()) {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let attributeContainerView = configure(UIView()) {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
    }
    
    let stackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 2
    }
    
    override func setupViews() {
        super.setupViews()
        stackView.addArrangedSubviews(titleLabel, siteLabel, typeLabel)

        attributeContainerView.addSubview(stackView)

        stackView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(8)
        }
        
        self.contentView.addSubview(attributeContainerView)

        attributeContainerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview().inset(8)
            maker.top.bottom.equalToSuperview()
        }
    }
    
    func bind(attribute: MovieAttribute) {
        titleLabel.text = attribute.name
        siteLabel.text = attribute.site
        typeLabel.text = attribute.type
    }
    
}
