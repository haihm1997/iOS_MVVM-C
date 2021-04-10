//
//  MovieAPIRouter.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire

enum MovieAPIRouter: EndPointConvertible {
    case movies

    var method: HTTPMethod {
        switch self {
        case .movies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .movies:
            return "/popular"
        }
    }
    
    var encoder: HTTPEncoder {
        switch self {
        case .movies:
            // Just for test
            return .urlEncoder(parameters: ["api_key": "802b2c4b88ea1183e50e6b285a27696e"])
        }
    }
    
}
