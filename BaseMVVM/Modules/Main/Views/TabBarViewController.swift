//
//  TabBarViewController.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum SmartPOSTabBarItemType: Int, CaseIterable {
    case home = 0
    case order = 1
    case addOrder = 2
    case notification = 3
    case account = 4
    
    var icon: UIImage? {
        switch self {
        case .home:
            return UIImage(name: .tabBarHome)?.withRenderingMode(.alwaysTemplate)
        case .order:
            return UIImage(name: .tabBarOrder)?.withRenderingMode(.alwaysTemplate)
        case .addOrder:
            return UIImage(name: .tabBarAddOrder)?.withRenderingMode(.alwaysTemplate)
        case .notification:
            return UIImage(name: .tabBarNotification)?.withRenderingMode(.alwaysTemplate)
        case .account:
            return UIImage(name: .tabBarAccount)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "home".localized()
        case .order:
            return "order".localized()
        case .addOrder:
            return ""
        case .notification:
            return "notification".localized()
        case .account:
            return "account".localized()
        }
    }
    
}

class TabBarController: UITabBarController {
    
    let smartPOSTabBar = CustomTabBar()
    
    var viewModel: TabBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        self.setValue(smartPOSTabBar, forKey: "tabBar")
        self.delegate = self
        
        smartPOSTabBar.outCenterButtonTapped.subscribe(onNext: { index in
            self.selectedIndex = index
        }).disposed(by: rx.disposeBag)
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard selectedIndex != SmartPOSTabBarItemType.addOrder.rawValue else { return }
        smartPOSTabBar.inTabItemTapped.accept(self.selectedIndex)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let addOrderIndex = SmartPOSTabBarItemType.addOrder.rawValue
        if viewController == tabBarController.viewControllers?[addOrderIndex] {
            return false
        } else {
            return true
        }
    }
    
}
