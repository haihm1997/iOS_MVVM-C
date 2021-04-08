//
//  Network.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/13/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public class Network {
    var configuration: NetworkConfiguration
    let afSection: Session
    
    init(configuration: NetworkConfiguration, interceptor: RequestInterceptor? = nil) {
        self.configuration = configuration
        self.afSection = Session(startRequestsImmediately: false,
                                 interceptor: interceptor,
                                 cachedResponseHandler: ResponseCacher(behavior: .doNotCache))
    }
}

public class SimpleNetwork: Network {
    init() {
        super.init(configuration: NetworkConfiguration(baseUrl: listingBaseUrl))
    }
    
    public func updateLanguage(_ language: String?) {
        self.configuration.language = language
    }
}

public class RefreshableTokenNetwork: Network {
    private let interceptor: NetworkInterceptor
    public let autoRefreshToken = PublishSubject<String?>()
    
    var networkAutoRefreshToken: Observable<String?> {
        return autoRefreshToken.asObserver().observeOn(MainScheduler.instance)
    }
    
    public init() {
        let config = NetworkConfiguration(baseUrl: listingBaseUrl)
        interceptor = NetworkInterceptor(configuration: config)
        super.init(configuration: config, interceptor: interceptor)
        interceptor.afSession = self.afSection
    }
    
    public func updateToken(_ token: String?) {
        interceptor.updateToken(token) { [weak self] (token) in
            self?.autoRefreshToken.onNext(token)
        }
    }
    
    public func updateLanguage(_ code: String?) {
        interceptor.updateLanguage(code)
    }
    
    public func clearCurrentSession() -> Completable {
        return Completable.create { [unowned self] (callBack) -> Disposable in
            self.interceptor.updateToken(nil, completionHandler: nil)
            callBack(.completed)
            return Disposables.create()
        }
    }
    
}




