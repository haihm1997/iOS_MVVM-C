//
//  ExtendApplication.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject

public class ExtendApplication {
    
    public static let shared = ExtendApplication()
    
    let movieService = Assembler.resolve(MovieServiceType.self)!
    let starWarService = Assembler.resolve(StarWarServiceType.self)!
    
}
