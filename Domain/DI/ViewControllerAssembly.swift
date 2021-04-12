//
//  ViewControllerAssembly.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 11/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

struct ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(HomeViewController.self) { resolver in
            let homeVC = HomeViewController()
            homeVC.viewModel = resolver.resolve(HomeViewModel.self)!
            return homeVC
        }
        
    }
    
}