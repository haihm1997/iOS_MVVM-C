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

enum HomeSection {
    case movies(viewModel: MovieSectionViewModel)
    case starships(viewModel: StarWarSectionViewModel)
}

class HomeViewModel: BaseViewModel {
    
    // Output
    let outAllSections = BehaviorRelay<[HomeSection]>(value: [])
    var outError: Observable<ProjectError>
    var outActivity: Observable<Bool>
    
    init(blockUserCase: BlockUseCaseType,
         movieUserCase: MovieUserCaseType,
         starWarUserCase: StarWarUserCaseType) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        
        blockUserCase.fetchBlocks().subscribe(onNext: { blocks in
            let movieObservables = Observable<[Movie]>.combineLatest(blocks.movieBlocks.map { _ in movieUserCase.fetchPopularMovies() })
            let starshipObservables = Observable<[StarShip]>.combineLatest(blocks.starShipBlocks.map { block in
                starWarUserCase.fetchStarships(by: block.query ?? "")
            })
            Observable.combineLatest(movieObservables, starshipObservables)
                .trackError(with: errorTracker)
                .trackActivity(LOADING_KEY, with: activityTracker)
                .map { movies, starships -> [HomeSection] in
                    let movieViewModels = movies.compactMap { MovieSectionViewModel(data: $0) }.map { HomeSection.movies(viewModel: $0) }
                    let starWarViewModels = starships.compactMap { StarWarSectionViewModel(data: $0) }.map { HomeSection.starships(viewModel: $0) }
                    return movieViewModels + starWarViewModels
                }.bind(to: self.outAllSections)
                .disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
    }
    
}
