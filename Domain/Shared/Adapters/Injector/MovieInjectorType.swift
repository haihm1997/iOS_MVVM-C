//
//  MovieInjectorType.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public protocol MovieInjectorType {
    func getMovieService() -> MovieServiceType
}
