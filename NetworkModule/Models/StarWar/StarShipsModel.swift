//
//  StarShipsModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public struct StarShipsModel: Decodable {
    var count: Int
    var all: [StarShipModel]
    
    enum CodingKeys: String, CodingKey {
      case count
      case all = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? -1
        all = try container.decodeIfPresent([StarShipModel].self, forKey: .all) ?? []
    }
}
