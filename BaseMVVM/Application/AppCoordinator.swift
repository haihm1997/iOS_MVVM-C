//
//  AppCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import Swinject
import RxSwift

class AppCoordinator: BaseCoordinator {
    
    var window: UIWindow?
    
    public init(window: UIWindow?) {
        super.init(parent: nil)
        self.window = window
    }
    
    override func start() {
        let tabBarCoordinator = TabBarCoordinator(parent: self)
        coordinate(with: tabBarCoordinator)
        window?.rootViewController = tabBarCoordinator.tabBarVC
        window?.makeKeyAndVisible()
    }
    
}
