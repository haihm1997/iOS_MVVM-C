//
//  ErrorTracker.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 13/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final public class ErrorTracker {
    
    private let _subject = PublishSubject<Error>()
    
    func asDriver() -> Driver<Error> {
        return _subject.asDriver(onErrorDriveWith: Driver.empty())
    }
    
    func asObservsable() -> Observable<Error> {
        return _subject.asObserver().observeOn(MainScheduler.instance)
    }
    
    private func onError(_ error: Error) {
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
    
}

extension ErrorTracker: DomainConvertible {
    
    public func asDomain() -> Observable<ProjectError> {
        return self.asObservsable().compactMap {
            return $0.asDomainError()
        }
    }
    
}

// MARK: - ErrorTracker + PrimitiveSequence
extension ErrorTracker {
    
    // Observable
    fileprivate func trackError<O: ObservableType>(from source: O) -> Observable<O.Element> {
        return source.do(onError: onError)
    }
    
    // Single
    fileprivate func trackError<E>(from source: Single<E>) -> Single<E> {
        return source.do(onError: onError)
    }
    
    // Completable
    fileprivate func trackError(from source: Completable) -> Completable {
        return source.do(onError: onError)
    }
    
    //Maybe
    fileprivate func trackError<E>(from source: Maybe<E>) -> Maybe<E> {
        return source.do(onError: onError)
    }
    
}

// MARK: - Operators
extension ObservableType {
    func trackError(with tracker: ErrorTracker) -> Observable<Element> {
        return tracker.trackError(from: self).catchErrorJustComplete()
    }
}

extension PrimitiveSequenceType where Trait == SingleTrait {
    func trackError(_ tracker: ErrorTracker) -> Single<Element> {
        return tracker.trackError(from: self.primitiveSequence)
    }
}

extension PrimitiveSequenceType where Trait == CompletableTrait, Element == Never {
    func trackError(_ tracker: ErrorTracker) -> Completable {
        return tracker.trackError(from: self.primitiveSequence).catchError { _ in
            return .empty()
        }
    }
}

extension PrimitiveSequenceType where Trait == MaybeTrait {
    func trackError(_ tracker: ErrorTracker) -> Maybe<Element> {
        return tracker.trackError(from: self.primitiveSequence).catchError { _ in .empty() }
    }
}

