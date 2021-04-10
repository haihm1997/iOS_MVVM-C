//
//  NetworkError.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

import Alamofire

public enum NetworkError: Error {
    case undefined
    case lostInternetConnection
    case errorMessage(message: String, code: String)
    case other(error: Error)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .undefined:
            return "Undefined"
        case .errorMessage(let message, _):
            return message
        case .other(let error):
            return error.localizedDescription
        case .lostInternetConnection:
            return "Lost Conection!"
        }
    }
}

//MARK: - Mapping

public protocol NetworkErrorConvertible {
    func asNetworkError() -> NetworkError
}

extension NetworkError: NetworkErrorConvertible {
    public func asNetworkError() -> NetworkError {
        return self
    }
}

public extension Error {
    func asNetworkError() -> NetworkError {
        (self as? NetworkErrorConvertible)?.asNetworkError() ?? .other(error: self)
    }
}

extension AFError: NetworkErrorConvertible {
    public func asNetworkError() -> NetworkError {
        if let error = self.underlyingError as NSError?, error.domain == NSURLErrorDomain {
            if error.code == -1009 {
                return .lostInternetConnection
            }
            return .other(error: error)
        }
        
        return (self.underlyingError as? NetworkErrorConvertible)?.asNetworkError() ?? .other(error: self)
    }
}
