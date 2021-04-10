//
//  EndpointConvertible.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire

public protocol EndPointConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var encoder: HTTPEncoder { get }
    var headers: [String: String]? { get }
    
    func asURLRequest(configuration: NetworkConfiguration) throws -> URLRequest
}
 
public extension EndPointConvertible {
    
    var path: String {
        return ""
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    func asURLRequest(configuration: NetworkConfiguration) throws -> URLRequest {
        var request = URLRequest(url: configuration.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        switch encoder {
        case .jsonEncoder(let parameters):
            request = try JSONEncoding.default.encode(request, with: parameters)
        case .urlEncoder(let parameters):
            request = try URLEncoding.default.encode(request, with: parameters)
        case .urlJsonEncoder(let jsonParameters, let urlParameters):
            request = try JSONEncoding.default.encode(request, with: jsonParameters)
            request = try URLEncoding.default.encode(request, with: urlParameters)
        default:
            break
        }
        NetworkLogger.log(request)
        return request
    }
}
