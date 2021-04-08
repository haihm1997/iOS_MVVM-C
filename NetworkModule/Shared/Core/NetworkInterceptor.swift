//
//  NetworkInterceptor.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/13/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire

class NetworkInterceptor: RequestInterceptor {
    
    private typealias RetryHandler = (RetryResult) -> Void
    
    private var token: String?
    private(set) var languageCode: String?
    private let _lock = NSRecursiveLock()
    
    var isRefreshing = false
    private var retryHandlers = [RetryHandler]()
    private var refreshCallBack: ((String?) -> Void)?
    unowned var afSession: Session!
    private let configuration: NetworkConfiguration
    
    init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    func updateToken(_ token: String?, completionHandler: ((String?) -> Void)?) {
        _lock.lock(); defer { _lock.unlock() }
        self.token = token
        self.refreshCallBack = completionHandler
    }
    
    func updateLanguage(_ code: String?) {
        _lock.lock(); defer { _lock.unlock() }
        self.languageCode = code
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var modifierRequest = urlRequest
        var headers = modifierRequest.allHTTPHeaderFields ?? [:]
        // Declear update header
        headers["x-api-key"] = "API_KEY"
        headers["Accept-Language"] = languageCode
        
        if let token = token {
            headers["authorization"] = "Beared \(token)"
        }
        
        modifierRequest.allHTTPHeaderFields = headers
        completion(.success(modifierRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        _lock.lock(); defer { _lock.unlock() }
        
        if request.retryCount != 0 {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if (error as NSError).domain == NSURLErrorDomain, (error as NSError).code == NSURLErrorNetworkConnectionLost {
            completion(.retry)
            return
        }
        
//        guard let idToken = self.token, let vinmecError = (error as? AFError)?.underlyingError as? VinmecAPIError, case .expiredToken = vinmecError else {
//            completion(.doNotRetryWithError(error))
//            return
//        }
//
//        self.retryHandlers.append(completion)
//
//        if !isRefreshing {
//            isRefreshing = true
//            refreshToken(idToken) { [weak self](newToken) in
//                guard let self = self else { return }
//
//                self._lock.lock()
//                defer {
//                    self._lock.unlock()
//                    self.refreshCallback?(newToken)
//                }
//
//                self.isRefreshing = false
//                guard let newToken = newToken, self.token != nil else {
//                    self.token = nil
//                    self.retryHandlers.forEach { $0(.doNotRetry) }
//                    self.retryHandlers = []
//                    return
//                }
//                self.token = newToken
//                self.retryHandlers.forEach { $0(.retry) }
//                self.retryHandlers = []
//            }
//        }
    }
    
    private func refreshToken(_ token: String, completion: @escaping (String?)->Void) {
//        let request = afSession.request(RequestConverter(configuration: configuration, endpoint: AuthenRouter.refreshToken(token: token))).validate().responseDecodable(of: LoginTokenModel.self) { (response) in
//            completion(response.value?.token)
//        }
//        request.resume()
    }
    
}

