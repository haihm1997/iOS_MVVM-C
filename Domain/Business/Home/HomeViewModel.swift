//
//  HomeViewModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 09/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class HomeViewModel: BaseViewModel {
    
    // Output
    let outMovies = BehaviorRelay<[Movie]>(value: [])
    var outError: Observable<ProjectError>
    var outActivity: Observable<Bool>
    
    init(injector: MovieInjectorType) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        injector.getMovieService()
            .fetchPopularMovies()
            .asObservable()
            .trackError(with: errorTracker)
            .trackActivity(LOADING_KEY, with: activityTracker)
            .bind(to: outMovies)
            .disposed(by: rx.disposeBag)
        
    }
    
}
