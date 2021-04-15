//
//  ActivityTracker.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 14/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public let LOADING_KEY: String = "loading"

final public class ActivityTracker<Activity: Hashable> {
    typealias State = [Activity: Bool]
    
    private let _activityState = BehaviorRelay<State>(value: [:])
    
    private func startActivity(_ activity: Activity) {
        update(status: true, for: activity)
    }
    
    private func stopActivity(_ activity: Activity) {
        update(status: false, for: activity)
    }
    
    private func update(status: Bool, for activity: Activity) {
        var state = _activityState.value
        if state[activity] != status {
            state[activity] = status
            _activityState.accept(state)
        }
    }
    
    public func status(for activity: Activity) -> Observable<Bool> {
        return _activityState.compactMap { state -> Bool? in
            return state[activity]
        }.distinctUntilChanged().observeOn(MainScheduler.instance)
    }
    
    public func statusForAllActivity() -> Observable<Bool> {
        return _activityState.map {
            $0.reduce(false) { (result, keyValue) -> Bool in
                return result || keyValue.value
            }
        }.distinctUntilChanged().observeOn(MainScheduler.instance)
    }
    
}

// MARK: - ActivityTracker+
extension ActivityTracker {
    
    // Observable
    fileprivate func trackActivity<O: ObservableType>(_ activity: Activity, from source: O) -> Observable<O.Element> {
        return source.do(onError: { _ in
            self.stopActivity(activity)
        }, onCompleted: {
            self.stopActivity(activity)
        }, onSubscribe: {
            self.startActivity(activity)
        }, onDispose: {
            self.stopActivity(activity)
        })
    }
    
    // Single
    fileprivate func trackActivity<S>(_ activity: Activity, from source: Single<S>) -> Single<S> {
        return source.do(afterSuccess: { _ in
            self.stopActivity(activity)
        }, afterError: { _ in
            self.stopActivity(activity)
        }, onSubscribe: {
            self.startActivity(activity)
        }, onDispose: {
            self.stopActivity(activity)
        })
    }
    
    //Completable
    fileprivate func trackActivity(_ activity: Activity, from source: Completable) -> Completable {
        return source.do(afterError: { _ in
            self.stopActivity(activity)
        }, afterCompleted: {
            self.stopActivity(activity)
        }, onSubscribe: {
            self.startActivity(activity)
        }, onDispose: {
            self.stopActivity(activity)
        })
    }
    
    // Maybe
    fileprivate func trackActivity<M>(_ activity: Activity, from source: Maybe<M>) -> Maybe<M> {
        return source.do(afterNext: { _ in
            self.stopActivity(activity)
        }, afterError: { _ in
            self.stopActivity(activity)
        }, afterCompleted: {
            self.stopActivity(activity)
        }, onSubscribe: {
            self.startActivity(activity)
        }, onDispose: {
            self.stopActivity(activity)
        })
    }
        
    //ActivityTracker + SharedSequence
    fileprivate func trackActivity<O: SharedSequenceConvertibleType>(_ activity: Activity, from source: O) -> SharedSequence<O.SharingStrategy, O.Element> {
        return source.do(afterCompleted: {
            self.stopActivity(activity)
        }, onSubscribe: {
            self.startActivity(activity)
        }, onDispose: {
            self.stopActivity(activity)
        })
    }
}

// MARK: - Operators
extension ObservableType {
    func trackActivity<Activity: Hashable>(_ activity: Activity, with tracker: ActivityTracker<Activity>) -> Observable<Element> {
        return tracker.trackActivity(activity, from: self)
    }
}

extension PrimitiveSequenceType where Trait == SingleTrait {
    func trackActivity<Activity: Hashable>(_ activity: Activity, with tracker: ActivityTracker<Activity>) -> Single<Element> {
        return tracker.trackActivity(activity, from: self.primitiveSequence)
    }
}

extension PrimitiveSequenceType where Trait == CompletableTrait, Element == Never {
    func trackActivity<Activity: Hashable>(_ activity: Activity, with tracker: ActivityTracker<Activity>) -> Completable {
        return tracker.trackActivity(activity, from: self.primitiveSequence)
    }
}

extension PrimitiveSequenceType where Trait == MaybeTrait {
    func trackActivity<Activity: Hashable>(_ activity: Activity, with tracker: ActivityTracker<Activity>) -> Maybe<Element> {
        return tracker.trackActivity(activity, from: self.primitiveSequence)
    }
}

extension SharedSequenceConvertibleType {
    func trackActivity<Activity: Hashable>(_ activity: Activity, with tracker: ActivityTracker<Activity>) -> SharedSequence<SharingStrategy, Element> {
        return tracker.trackActivity(activity, from: self)
    }
}
