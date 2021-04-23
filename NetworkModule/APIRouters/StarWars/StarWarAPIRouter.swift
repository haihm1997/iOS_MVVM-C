//
//  StarWarAPIRouter.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire

public enum StarWarAPIRouter: EndPointConvertible {
    
    case searchStarShips(name: String)
    
    public var method: HTTPMethod {
        switch self {
        case .searchStarShips:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .searchStarShips:
            return "/starships"
        }
    }
    
    public var encoder: HTTPEncoder {
        switch self {
        case .searchStarShips(let query):
            return .urlEncoder(parameters: ["search": query])
        }
    }
    
}
