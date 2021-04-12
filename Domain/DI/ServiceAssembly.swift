//
//  ServiceAssembly.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 11/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

struct ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(NetworkConfiguration.self, serviceName: .movieService) { resolver in
            return NetworkConfiguration(baseURL: MOVIE_URL)
        }
        
        container.register(Network.self, serviceName: .movieService) { (resolver: Resolver) in
            let configuration = resolver.resolve(NetworkConfiguration.self, serviceName: .movieService)!
            return Network(configuration: configuration)
        }
        
        container.register(MovieServiceType.self) { (resolver: Resolver) in
            let movieNetwork = resolver.resolve(Network.self, serviceName: .movieService)!
            return MovieService(network: movieNetwork)
        }
    }
    
}
