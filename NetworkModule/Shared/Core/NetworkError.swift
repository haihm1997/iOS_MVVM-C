//
//  NetworkError.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/13/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case encodingFailed
    case serverError
    case lostInternetConnection
    case other(error: Error)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Encoding Failed!"
        case .serverError:
            return ""
        case .lostInternetConnection:
            return "Lost internet connection"
        case .other(let error):
            return error.localizedDescription
        }
    }
    
}

// MARK: - Mapping Error

protocol NetworkErrorConvertible {
    func asNetworkError() -> NetworkError
}

extension NetworkError: NetworkErrorConvertible {
    func asNetworkError() -> NetworkError {
        return self
    }
}

extension Error {
    
    func asNetworkError() -> NetworkError {
        (self as? NetworkErrorConvertible)?.asNetworkError() ?? .other(error: self)
    }
    
}

extension AFError: NetworkErrorConvertible {
    
    func asNetworkError() -> NetworkError {
        if let error = self.underlyingError as NSError?, error.domain == NSURLErrorDomain {
            // Code = -1009 is lost internet connection
            if error.code == -1009 {
                return .lostInternetConnection
            }
            return .other(error: error)
        }
        
        return (self.underlyingError as? NetworkErrorConvertible)?.asNetworkError() ?? .other(error: self)
    }

}


