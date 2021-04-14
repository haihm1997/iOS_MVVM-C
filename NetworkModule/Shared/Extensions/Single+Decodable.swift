//
//  Single+Decodable.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import RxSwift
import Alamofire

public extension PrimitiveSequenceType where Element: DataRequest, Trait == SingleTrait {
    
    func responseDecodable<T: Decodable>(of type: T.Type = T.self, decoder: DataDecoder = JSONDecoder()) -> Single<T> {
        return flatMap { request -> Single<T> in
            return Single.create { single -> Disposable in
                let request = request.responseDecodable(of: type, decoder: decoder) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        print(error.localizedDescription)
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
    
    func responseData() -> Single<Data> {
        return flatMap { (request) -> Single<Data> in
            return Single.create { (single) -> Disposable in
                let request = request.responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
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
