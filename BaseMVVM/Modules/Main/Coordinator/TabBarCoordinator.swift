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

class TabBarCoordinator: ReactiveCoordinator<Void> {
    
    let window: UIWindow?
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        var controllers: [UIViewController] = []
        let tabBarController = Assembler.resolve(TabBarController.self)!
        
        let homeVC = HomeCoordinator()
        coordinate(to: homeVC).subscribe().disposed(by: rx.disposeBag)
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
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return Observable.never()
    }
    
}
