//
//  MovieModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 09/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public struct MovieResult: Decodable {
    let results: [MovieModel]
    
    enum Keys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        results = try container.decodeIfPresent([MovieModel].self, forKey: .results) ?? []
    }
}

public struct MovieModel: Decodable {
    let adult: Bool?
    let backdropPath: String
    let id: Int
    let title: String
    let releaseDate: String
    let vote: Double
    
    enum Keys: String, CodingKey {
        case adult, id, title
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case vote = "vote_average"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        vote = try container.decodeIfPresent(Double.self, forKey: .vote) ?? 0
    }
}

extension MovieModel: DomainConvertible {
    public func asDomain() -> Movie {
        return Movie(adult: adult,
                     backdropPath: backdropPath,
                     id: id,
                     title: title,
                     releaseDate: releaseDate,
                     vote: vote)
    }
}
