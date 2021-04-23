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
        
        let movieObservable2 = movieInjector.getMovieService()
            .fetchPopularMovies()
            .asObservable()
        
        let starWarObservable2 = starWarInjector.getStarWarService()
            .fetchStarships(by: "b")
            .asObservable()
        
        let starWarObservable3 = starWarInjector.getStarWarService()
            .fetchStarships(by: "c")
            .asObservable()

        Observable.combineLatest(movieObservable, starWarObservable, movieObservable2, starWarObservable2, starWarObservable3)
            .trackError(with: errorTracker)
            .trackActivity(LOADING_KEY, with: activityTracker)
            .map { movies, starships, movies2, starship2, starship3 -> [HomeSection] in
                let movieViewModel = MovieSectionViewModel(data: movies)
                let starWarViewModel = StarWarSectionViewModel(data: starships)
                let movie2ViewModel = MovieSectionViewModel(data: movies2)
                let starWar2ViewModel = StarWarSectionViewModel(data: starship2)
                let starWar3ViewModel = StarWarSectionViewModel(data: starship3)
                return [.movies(viewModel: movieViewModel),
                        .starships(viewModel: starWarViewModel),
                        .movies(viewModel: movie2ViewModel),
                        .starships(viewModel: starWar2ViewModel),
                        .starships(viewModel: starWar3ViewModel)]
            }.bind(to: outAllSections)
            .disposed(by: rx.disposeBag)
        
    }
    
}
