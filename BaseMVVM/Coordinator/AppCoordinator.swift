//
//  AppCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import UIKit
import Swinject

public class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow?
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
        addChildCoordinator(homeCoordinator)
    }
    
    override func finish() {
        removeAllChildCoordinator()
    }
    
}
