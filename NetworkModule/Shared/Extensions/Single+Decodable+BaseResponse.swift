//
//  Single+Decodable+BaseResponse.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import RxSwift
import Alamofire

// This protocol support decode specific raw data object from a exist formated JSON
public protocol BaseResponse: Decodable {
    associatedtype T
    
    var data: T { get }
}

public extension PrimitiveSequenceType where Element: DataRequest, Trait == SingleTrait {
    
    func responseDecodable<T: BaseResponse>(of type: T.Type = T.self, decoder: DataDecoder = JSONDecoder()) -> Single<T.T> {
        return flatMap { request -> Single<T.T> in
            return Single.create { single -> Disposable in
                let request = request.responseDecodable(of: type, decoder: decoder) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value.data))
                    case .failure(let error):
                        print(error)
                        single(.error(error.asDomainError()))
                    }
                }
                request.resume()
                return Disposables.create {
                    request.cancel()
                }
            }
        }
    }
    
}
