//
//  MyNavigationView.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 07/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxSwift

class MyNavigationView: BaseCustomView {
    
    let leftButtonImage = configure(UIImageView()) {
        $0.backgroundColor = .clear
        $0.image = UIImage(name: .back)
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = configure(UILabel()) {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    let leftButton = configure(UIButton()) {
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    let rightButton = configure(UIButton()) {
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var leftButtonIcon: UIImage? {
        didSet {
            leftButtonImage.image = leftButtonIcon
        }
    }
    
    var rightAction: Observable<Void> {
        return rightButton.rx.tap.asObservable()
    }
    
    var leftAction: Observable<Void> {
        return leftButton.rx.tap.asObservable()
    }
    
    override func setupViews() {
        self.backgroundColor = .white
        self.addSubviews(titleLabel, leftButtonImage, leftButton, rightButton)
        
        leftButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(36)
            maker.width.equalTo(100)
            maker.centerY.equalToSuperview()
        }
        
        leftButtonImage.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(32)
            maker.leading.equalToSuperview().inset(12)
            maker.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(36)
            maker.trailing.equalToSuperview().inset(12)
            maker.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
        }
    }
    
}
