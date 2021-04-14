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
    
    init(injector: MovieInjectorType) {
        let errorTracker = ErrorTracker()
        outError = errorTracker.asDomain()
        super.init()
        injector.getMovieService()
            .fetchPopularMovies()
            .asObservable()
            .trackError(with: errorTracker)
            .bind(to: outMovies)
            .disposed(by: rx.disposeBag)
        
    }
    
}
