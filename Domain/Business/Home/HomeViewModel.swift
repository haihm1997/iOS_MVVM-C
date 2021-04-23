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

protocol HomeSectionType { }

enum HomeSection {
    case movies(viewModel: MovieSectionViewModel)
    case starships(viewModel: StarWarSectionViewModel)
}

class HomeViewModel: BaseViewModel {
    
    // Output
    let outAllSections = BehaviorRelay<[HomeSection]>(value: [])
    var outError: Observable<ProjectError>
    var outActivity: Observable<Bool>
    
    init(movieInjector: MovieInjectorType, starWarInjector: StarWarInjectorType) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        let movieObservable = movieInjector.getMovieService()
            .fetchPopularMovies()
            .asObservable()
        
        let starWarObservable = starWarInjector.getStarWarService()
            .fetchStarships(by: "a")
            .asObservable()

        Observable.combineLatest(movieObservable, starWarObservable)
            .trackError(with: errorTracker)
            .trackActivity(LOADING_KEY, with: activityTracker)
            .map { movies, starships -> [HomeSection] in
                let movieViewModel = MovieSectionViewModel(data: movies)
                let starWarViewModel = StarWarSectionViewModel(data: starships)
                return [.movies(viewModel: movieViewModel), .starships(viewModel: starWarViewModel)]
            }.bind(to: outAllSections)
            .disposed(by: rx.disposeBag)
            
    }
    
}
