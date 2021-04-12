//
//  ViewModelAssembly.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 11/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

struct ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(HomeViewModel.self) { resolver in
            return HomeViewModel(injector: ExtendApplication.shared)
        }
        
    }
    
}
