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

class AppCoordinator: ReactiveCoordinator<Void> {
    
    let window: UIWindow?
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        return coordinate(to: tabBarCoordinator)
    }
    
}
