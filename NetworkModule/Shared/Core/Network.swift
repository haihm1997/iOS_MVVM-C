//
//  Network.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

public class Network {
    let configuration: NetworkConfiguration
    let session: Session
    
    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
        self.session = Session(startRequestsImmediately: false,
                               interceptor: nil,
                               serverTrustManager: nil,
                               cachedResponseHandler: ResponseCacher(behavior: .doNotCache))
    }
}

extension Network: ReactiveCompatible {}

extension Reactive where Base: Network {
    public func request(_ route: EndPointConvertible) -> Single<DataRequest> {
        return request(RequestConvertible(configuration: base.configuration, endpoint: route))
    }
    
    public func request(_ request: RequestConvertible) -> Single<DataRequest> {
        return Single.create { [session = base.session] callback -> Disposable in
            callback(.success(session.request(request)))
            return Disposables.create()
        }
    }
}
