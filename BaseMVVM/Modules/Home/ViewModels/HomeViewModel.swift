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

enum HomeSection {
    case movies(viewModel: MovieSectionViewModel)
    case starships(viewModel: StarWarSectionViewModel)
    
    init(from type: BlockType) {
        switch type {
        case .movies:
            self = .movies(viewModel: .init(data: []))
        case .starShip:
            self = .starships(viewModel: .init(data: []))
        }
    }
    
    func merge(other: HomeSection) -> HomeSection {
        switch self {
        case .movies(let viewModel):
            switch other {
            case .movies(let newViewModel):
                return .movies(viewModel: .init(data: viewModel.data + newViewModel.data))
            default:
                return self
            }
        case .starships(let viewModel):
            switch other {
            case .starships(let newViewModel):
                return .starships(viewModel: .init(data: viewModel.data + newViewModel.data))
            default:
                return self
            }
        }
    }
    
}

class HomeViewModel: BaseViewModel {
    
    // Input
    let inTapSomething = PublishRelay<Int>()
    
    // Output
    let outAllSections = BehaviorRelay<[HomeSection]>(value: [])
    let outError: Observable<ProjectError>
    let outActivity: Observable<Bool>
    let outDidTapMovie = PublishSubject<Movie>()
    let outLastViewedId = BehaviorRelay<Int?>(value: nil)
        
    init(blockUserCase: BlockUseCaseType,
         movieUserCase: MovieUserCaseType,
         starWarUserCase: StarWarUserCaseType) {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker<String>()
        outError = errorTracker.asDomain()
        outActivity = activityTracker.status(for: LOADING_KEY)
        super.init()
        
        let getBlockObs = blockUserCase.fetchBlocks().share()

        getBlockObs
            .map { $0.map(HomeSection.init) }
            .bind(to: outAllSections).disposed(by: rx.disposeBag)
        
        getBlockObs
            .flatMap { Observable.from($0.enumerated()) }
            .flatMap { index, blockType -> Observable<(Int, HomeSection)> in
                switch blockType {
                case .movies:
                    return movieUserCase.fetchPopularMovies()
                        .map { HomeSection.movies(viewModel: .init(data: $0)) }
                        .withLatestFrom(Observable.just(index)) { ($1, $0) }
                case .starShip(let query):
                    return starWarUserCase.fetchStarships(by: query)
                        .map { HomeSection.starships(viewModel: .init(data: $0)) }
                        .withLatestFrom(Observable.just(index)) { ($1, $0) }
                }
            }
            .withLatestFrom(outAllSections) { ($0.0, $0.1, $1) }
            .map { index, loadedSection, result -> [HomeSection] in
                var newResult = result
                newResult[index] = result[index].merge(other: loadedSection)
                return newResult
            }
            .trackError(with: errorTracker)
            .trackActivity(LOADING_KEY, with: activityTracker)
            .bind(to: outAllSections)
            .disposed(by: rx.disposeBag)
        
    }
    
}
