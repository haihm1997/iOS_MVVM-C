//
//  StarWarService.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift

public protocol StarWarServiceType {
    func fetchStarships(by name: String) -> Single<[StarShip]>
}

public class StarWarService {
    
    public let network: Network
    
    public init(network: Network) {
        self.network = network
    }
    
}

extension StarWarService: StarWarServiceType {
    
    public func fetchStarships(by name: String) -> Single<[StarShip]> {
        return network.rx.request(StarWarAPIRouter.searchStarShips(name: name))
            .validate()
            .responseDecodable(of: StarShipsModel.self)
            .map { $0.all }
            .mapToDomain()
    }
    
}


