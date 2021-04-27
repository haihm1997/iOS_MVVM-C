//
//  Rx+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 14/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    
    func ignoreNil<Wrapped>() -> Observable<Wrapped> where Element == Optional<Wrapped> {
        return flatMap { (element) -> Observable<Wrapped> in
            switch element {
            case .some(let value):
                return Observable.just(value)
            case .none:
                return Observable.empty()
            }
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
}

public extension ObservableConvertibleType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        return self.asObservable().catchError { _ in .empty() }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver(onErrorDriveWith: Driver.empty())
    }
    
}
