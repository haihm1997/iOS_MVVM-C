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
            let blockUserCase = resolver.resolve(BlockUseCaseType.self)!
            let movieUserCase = resolver.resolve(MovieUserCaseType.self)!
            let starWarUserCase = resolver.resolve(StarWarUserCaseType.self)!
            return HomeViewModel(blockUserCase: blockUserCase,
                                 movieUserCase: movieUserCase,
                                 starWarUserCase: starWarUserCase)
        }
        
        container.register(MovieDetailViewModel.self) { (resolver: Resolver, id: Int) in
            let movieUserCase = resolver.resolve(MovieUserCaseType.self)!
            return MovieDetailViewModel(movieUserCase: movieUserCase, id: id)
        }
        
        container.register(TabBarViewModel.self) { resolver in
            return TabBarViewModel()
        }
        
    }
    
}
