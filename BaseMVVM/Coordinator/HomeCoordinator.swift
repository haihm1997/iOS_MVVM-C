//
//  HomeCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

class HomeCoordinator: ReactiveCoordinator<Void> {
    
    let window: UIWindow?
    var nav: UINavigationController?
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    public override func start() -> Observable<Void> {
        let homeVC = Assembler.resolve(HomeViewController.self)!
        let nav = UINavigationController(rootViewController: homeVC)
        self.nav = nav
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return Observable.never()
    }
    
}
