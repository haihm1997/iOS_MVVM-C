//
//  RequestConvertible.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire

public class RequestConvertible: URLRequestConvertible {
    let configuration: NetworkConfiguration
    let endpoint: EndPointConvertible
    
    init(configuration: NetworkConfiguration, endpoint: EndPointConvertible) {
        self.configuration = configuration
        self.endpoint = endpoint
    }
    
    public func asURLRequest() throws -> URLRequest {
        try endpoint.asURLRequest(configuration: configuration)
    }
}
