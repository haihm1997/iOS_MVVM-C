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
        
        // MARK: - Network Configuration
        container.register(NetworkConfiguration.self, serviceName: .movieService) { resolver in
            return NetworkConfiguration(baseURL: MOVIE_URL)
        }
        
        container.register(NetworkConfiguration.self, serviceName: .starWar) { resolver in
            return NetworkConfiguration(baseURL: START_WAR)
        }

        // MARK: - Network
        container.register(Network.self, serviceName: .starWar) { (resolver: Resolver) in
            let configuration = resolver.resolve(NetworkConfiguration.self, serviceName: .starWar)!
            return Network(configuration: configuration)
        }
        
        container.register(Network.self, serviceName: .movieService) { (resolver: Resolver) in
            let configuration = resolver.resolve(NetworkConfiguration.self, serviceName: .movieService)!
            return Network(configuration: configuration)
        }
        
        // MARK: - Services
        
        container.register(MovieServiceType.self) { (resolver: Resolver) in
            let movieNetwork = resolver.resolve(Network.self, serviceName: .movieService)!
            return MovieService(network: movieNetwork)
        }
        
        container.register(StarWarServiceType.self) { (resolver: Resolver) in
            let starWarNetwork = resolver.resolve(Network.self, serviceName: .starWar)!
            return StarWarService(network: starWarNetwork)
        }
    }
    
}
