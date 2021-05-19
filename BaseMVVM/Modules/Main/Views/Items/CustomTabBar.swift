//
//  SmartPOSTabBar.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import SnapKit
import RxRelay
import RxSwift

class CustomTabBar: UITabBar {
    
    let tabBarView = TabBarView()
    
    private var centerButtonImg = configure(UIImageView()) {
        $0.image = UIImage(name: .tabBarAddOrder)
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    private var latestTappedPointx: CGFloat = 0
    
    var inTabItemTapped = PublishRelay<Int>()
    var outCenterButtonTapped = PublishRelay<Int>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private var shapeLayer: CALayer?
    
    private func commonInit() {
        setupViews()
        bind()
    }
    
    private func setupViews() {
        addSubviews(tabBarView, centerButtonImg)
        
        tabBarView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        
        centerButtonImg.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(64)
            maker.top.equalToSuperview().offset(-16)
            maker.centerX.equalToSuperview()
        }
    }
    
    private func bind() {
        inTabItemTapped.compactMap { SmartPOSTabBarItemType(rawValue: $0) }
            .bind(to: tabBarView.inTabItemTapped)
            .disposed(by: rx.disposeBag)
    }
    
    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        if centerButtonImg.frame.contains(point) {
            Observable.just(point.x).map { $0 != self.latestTappedPointx }
                .filter { $0 }
                .withLatestFrom(Observable.just(SmartPOSTabBarItemType.addOrder.rawValue))
                .bind(to: outCenterButtonTapped)
                .disposed(by: rx.disposeBag)
            self.latestTappedPointx = point.x
            return true
        }
        return self.bounds.contains(point)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = Constant.SafeArea.bottomPadding + Constant.Size.tabBarHeight
        return sizeThatFits
    }
    
}
