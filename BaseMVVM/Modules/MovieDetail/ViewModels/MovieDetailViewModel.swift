//
//  MovieDetailViewModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 06/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailViewModel: BaseViewModel {
    
    // Output
    let outAttributes = BehaviorRelay<[MovieAttribute]>(value: [])
    var outError: Observable<ProjectError>
    var outActivity: Observable<Bool>
    var didClose = PublishRelay<Int?>()
    
    init(movieUserCase: MovieUserCaseType,
         id: Int) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        
        movieUserCase.fetchMovieDetail(id: id)
            .trackError(with: errorTracker)
            .trackActivity(LOADING_KEY, with: activityTracker)
            .map { $0.attributes }
            .bind(to: outAttributes)
            .disposed(by: rx.disposeBag)
    }
    
}
