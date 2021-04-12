//
//  HomeCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

public class HomeCoordinator: BaseCoordinator {
    
    let window: UIWindow?
    var controller: UIViewController?
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let homeVC = Assembler.resolve(HomeViewController.self) else { return }
        self.controller = homeVC
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
    
    override func finish() {
        removeChildCoordinator(self)
    }
    
}
