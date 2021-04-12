//
//  Assembler+Service.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 11/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

extension Resolver {
    
    func resolve<T>(_ serviceType: T.Type, serviceName: AssemblerName? = nil) -> T? {
        return resolve(serviceType, name: serviceName?.named)
    }
    
    func resolve<T, Arg>(_ serviceType: T.Type, serviceName: AssemblerName? = nil, argument: Arg) -> T? {
        return resolve(serviceType, name: serviceName?.named, argument: argument)
    }
    
    func resolve<T, Arg1, Arg2>(_ serviceType: T.Type, serviceName: AssemblerName? = nil, arguments arg1: Arg1, _ arg2: Arg2) -> T? {
        return resolve(serviceType, arguments: arg1, arg2)
    }
    
    func resolve<T, Arg1, Arg2, Arg3>(_ serviceType: T.Type, serviceName: AssemblerName? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T? {
        return resolve(serviceType, name: serviceName?.named, arguments: arg1, arg2, arg3)
    }
    
    func resolve<T, Arg1, Arg2, Arg3, Arg4>(_ serviceType: T.Type, serviceName: AssemblerName? = nil, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> T? {
        return resolve(serviceType, name: serviceName?.named, arguments: arg1, arg2, arg3, arg4)
    }
    
}

extension Container {
    
    @discardableResult
    public func register<Service>(
        _ serviceType: Service.Type,
        serviceName: AssemblerName,
        factory: @escaping (_ resolver: Resolver) -> Service
    ) -> ServiceEntry<Service> {
        return _register(serviceType, factory: factory, name: serviceName.named)
    }
    
}
