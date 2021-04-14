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

extension NetworkError: DomainErrorConvertible {
    public func asDomainError() -> ProjectError {
        return .other(error: self)
    }
}

public extension Error {
    func asDomainError() -> ProjectError {
        (self as? DomainErrorConvertible)?.asDomainError() ?? .other(error: self)
    }
}

extension AFError: DomainErrorConvertible {
    public func asDomainError() -> ProjectError {
        if let error = self.underlyingError as NSError?, error.domain == NSURLErrorDomain {
            if error.code == NSURLErrorNotConnectedToInternet {
                return .lostInternetConnection
            }
            return .other(error: error)
        }
        return (self.underlyingError as? DomainErrorConvertible)?.asDomainError() ?? .other(error: self)
    }
}


