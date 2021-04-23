//
//  ExtendApplication.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

extension ExtendApplication: MovieInjectorType {
    
    public func getMovieService() -> MovieServiceType {
        return movieService
    }
    
}

extension ExtendApplication: StarWarInjectorType {
    
    public func getStarWarService() -> StarWarServiceType {
        return starWarService
    }
    
}
