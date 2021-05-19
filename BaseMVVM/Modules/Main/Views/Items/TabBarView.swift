//
//  TabBarView.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TabBarView: BaseCustomView {
    
    private let homeTabItem = configure(TabBarItemView(frame: TabBarItemView.rect)) {
        $0.icon = SmartPOSTabBarItemType.home.icon
        $0.title = SmartPOSTabBarItemType.home.title
        $0.tabItemType = .home
    }
    
    private let orderTabItem = configure(TabBarItemView(frame: TabBarItemView.rect)) {
        $0.icon = SmartPOSTabBarItemType.order.icon
        $0.title = SmartPOSTabBarItemType.order.title
        $0.tabItemType = .order
    }
    
    private let centerView = UIView(frame: TabBarItemView.rect)
    
    private let notificationTabItem = configure(TabBarItemView(frame: TabBarItemView.rect)) {
        $0.icon = SmartPOSTabBarItemType.notification.icon
        $0.title = SmartPOSTabBarItemType.notification.title
        $0.tabItemType = .notification
    }
    
    private let accountTabItem = configure(TabBarItemView(frame: TabBarItemView.rect)) {
        $0.icon = SmartPOSTabBarItemType.account.icon
        $0.title = SmartPOSTabBarItemType.account.title
        $0.tabItemType = .account
    }
    
    private let stackView = configure(UIStackView()) {
        $0.axis = .horizontal
        $0.backgroundColor = .white
        $0.distribution = .fillEqually
    }
    
    var inTabItemTapped = BehaviorRelay<SmartPOSTabBarItemType>(value: SmartPOSTabBarItemType.home)
    
    override func commonInit() {
        setupViews()
        bind()
        //activeLayout(at: .home)
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        stackView.addArrangedSubviews(homeTabItem, orderTabItem, centerView, notificationTabItem, accountTabItem)
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        inTabItemTapped.bind(to: activeTabItemBinder).disposed(by: rx.disposeBag)
    }
    
    private func activeLayout(at tab: SmartPOSTabBarItemType, animated: Bool = false) {
        homeTabItem.active(tab == .home, animated: animated)
        orderTabItem.active(tab == .order, animated: animated)
        notificationTabItem.active(tab == .notification, animated: animated)
        accountTabItem.active(tab == .account, animated: animated)
    }
    
}

extension TabBarView {
    
    var activeTabItemBinder: Binder<SmartPOSTabBarItemType> {
        return Binder(self) { target, itemType in
            target.activeLayout(at: itemType)
        }
    }
    
}
