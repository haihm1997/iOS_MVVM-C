//
//  TabBarCoordinator.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

class TabBarCoordinator: BaseCoordinator {
    
    var tabBarVC: UIViewController!
    
    override func start() {
        var controllers: [UIViewController] = []
        let tabBarController = Assembler.resolve(TabBarController.self)!
        
        let homeVC = HomeCoordinator(parent: self)
        coordinate(with: homeVC)
        controllers.append(homeVC.nav)
        
        let testVC = TestViewController()
        controllers.append(testVC)
        
        let testVC2 = TestViewController()
        controllers.append(testVC2)
        
        let testVC3 = TestViewController()
        controllers.append(testVC3)
        
        let otherVC = OtherViewController()
        controllers.append(otherVC)
        
        tabBarController.viewControllers = controllers
        tabBarVC = tabBarController
    }
    
}
