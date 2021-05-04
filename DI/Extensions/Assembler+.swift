//
//  Assembler+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 11/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Swinject

extension Assembler {
    
    static let shared: Assembler = {
        let container = Container()
        let assembler = Assembler([ServiceAssembly(),
                                   ViewModelAssembly(),
                                   ViewControllerAssembly(),
                                   UserCaseAssembly()],
                                  container: container)
        return assembler
    }()
    
    static func resolve<T>(_ serviceType: T.Type) -> T? {
        return Assembler.shared.resolver.resolve(serviceType)
    }
    
    static func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T? {
        return Assembler.shared.resolver.resolve(serviceType, argument: argument)
    }
    
    static func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2) -> T? {
        return Assembler.shared.resolver.resolve(serviceType, arguments: arg1, arg2)
    }
    
    static func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T? {
        return Assembler.shared.resolver.resolve(serviceType, arguments: arg1, arg2, arg3)
    }
    
    static func resolve<T, Arg1, Arg2, Arg3, Arg4>(_ serviceType: T.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> T? {
        return Assembler.shared.resolver.resolve(serviceType, arguments: arg1, arg2, arg3, arg4)
    }
    
}
