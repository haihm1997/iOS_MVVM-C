//
//  HTTPEncoder.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public enum HTTPEncoder {
    case noEncoder
    case urlEncoder(parameters: [String: Any])
    case jsonEncoder(parameters: [String: Any])
    case urlJsonEncoder(jsonParameters: [String: Any], urlParameters: [String: Any])
}
