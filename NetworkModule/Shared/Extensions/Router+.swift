//
//  Router+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/14/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import Foundation

protocol EndpointConvertible {
    func asURLRequest(configuration: NetworkConfiguration) throws -> URLRequest
}
