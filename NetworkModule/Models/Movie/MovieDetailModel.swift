//
//  MovieDetailModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 06/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public struct MovieDetailModel: Decodable {
    let id: Int
    let attributes: [MovieAttributeModel]
    
    enum Keys: String, CodingKey {
        case id, results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(Int.self, forKey: .id)
        attributes = try container.decodeIfPresent([MovieAttributeModel].self, forKey: .results) ?? []
    }
    
}

extension MovieDetailModel: DomainConvertible {
    
    public func asDomain() -> MovieDetail {
        return MovieDetail(id: id,
                           attributes: attributes.asDomain())
    }
}


public struct MovieAttributeModel: Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    enum Keys: String, CodingKey {
        case id, key, name, site, size, type
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(String.self, forKey: .id)
        key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        site = try container.decodeIfPresent(String.self, forKey: .site) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        size = try container.decodeIfPresent(Int.self, forKey: .size) ?? 0
    }
    
}

extension MovieAttributeModel: DomainConvertible {
    
    public func asDomain() -> MovieAttribute {
        return MovieAttribute(id: id,
                              name: name,
                              key: key,
                              site: site,
                              size: size,
                              type: type)
    }
    
}
