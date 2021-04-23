//
//  Movie.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 09/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public struct Movie {
    let adult: Bool?
    let backdropPath: String
    let id: Int
    let title: String
    let releaseDate: String
    let vote: Double
}

extension Movie {
    
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/w185\(backdropPath)"
    }
    
}
