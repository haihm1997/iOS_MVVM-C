//
//  StarShipModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public struct StarShipModel: Decodable {
    var name: String
    var model: String
    var manufacturer: String
    var cost: String
    var maximumSpeed: String
    var films: [String]
    
    enum Keys: String, CodingKey {
      case name
      case model
      case manufacturer
      case cost = "cost_in_credits"
      case length
      case maximumSpeed = "max_atmosphering_speed"
      case crewTotal = "crew"
      case passengerTotal = "passengers"
      case cargoCapacity = "cargo_capacity"
      case consumables
      case hyperdriveRating = "hyperdrive_rating"
      case starshipClass = "starship_class"
      case films
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer) ?? ""
        model = try container.decodeIfPresent(String.self, forKey: .model) ?? ""
        cost = try container.decodeIfPresent(String.self, forKey: .cost) ?? ""
        maximumSpeed = try container.decodeIfPresent(String.self, forKey: .maximumSpeed) ?? ""
        films = try container.decodeIfPresent([String].self, forKey: .films) ?? []
    }
}

extension StarShipModel: DomainConvertible {
    
    public func asDomain() -> StarShip {
        return StarShip(name: name,
                        model: model,
                        manufacturer: manufacturer,
                        cost: cost,
                        maximumSpeed: maximumSpeed,
                        films: films)
    }
    
}

