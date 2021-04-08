//
//  Network+RX.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/14/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct RequestConverter: URLRequestConvertible {
    
    let configuration: NetworkConfiguration
    let endpoint: EndpointConvertible
    
    func asURLRequest() throws -> URLRequest {
        try endpoint.asURLRequest(configuration: configuration)
    }
    
}

extension Network: ReactiveCompatible {}
extension Reactive where Base: Network {
    
    func request(_ endpoint: EndpointConvertible, interceptor: RequestInterceptor? = nil) -> Single<DataRequest> {
        return self.base.afSection.rx.request(RequestConverter(configuration: base.configuration, endpoint: endpoint),
                                              interceptor: interceptor)
    }
    
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 intercepter: RequestInterceptor? = nil) -> Single<DataRequest> {
        return self.base.afSection.rx.request(convertible,
                                              method: method,
                                              parameters: parameters,
                                              encoding: encoding,
                                              headers: headers,
                                              interceptor: intercepter)
    }
}

extension Session: ReactiveCompatible {}
extension Reactive where Base == Session {
    
    func request(_ request: URLRequestConvertible, interceptor: RequestInterceptor? = nil) -> Single<DataRequest> {
        return Single.create { [afSession = self.base] (callBack) -> Disposable in
            callBack(.success(afSession.request(request, interceptor: interceptor)))
            return Disposables.create()
        }
    }
    
    func request(_ contertible: URLConvertible,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 interceptor: RequestInterceptor? = nil) -> Single<DataRequest> {
        return Single.create { [afSession = self.base] (callBack) -> Disposable in
            let request = afSession.request(contertible,
                                            method: method,
                                            parameters: parameters,
                                            encoding: encoding,
                                            headers: headers,
                                            interceptor: interceptor)
            callBack(.success(request))
            return Disposables.create()
        }
    }
    
}
