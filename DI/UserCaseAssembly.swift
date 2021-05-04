//
//  UserCaseAssembly.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 03/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

struct UserCaseAssembly: Assembly {
    
    func assemble(container: Container) {
    
        container.register(BlockUseCaseType.self) { resolver in
            return BlockUseCase()
        }
        
        container.register(MovieUserCaseType.self) { resolver in
            return MovieUserCase(injector: ExtendApplication.shared)
        }
        
        container.register(StarWarUserCaseType.self) { resolver in
            return StarWarUserCase(injector: ExtendApplication.shared)
        }
        
    }
    
}
