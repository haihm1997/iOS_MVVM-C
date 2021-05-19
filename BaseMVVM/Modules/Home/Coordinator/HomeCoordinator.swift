//
//  HomeCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 12/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa

class HomeCoordinator: ReactiveCoordinator<Void> {
    
    var nav: UINavigationController!
        
    public override func start() -> Observable<Void> {
        let homeVC = Assembler.resolve(HomeViewController.self)!
        let nav = UINavigationController(rootViewController: homeVC)
        nav.setNavigationBarHidden(true, animated: false)
        self.nav = nav
        
        homeVC.viewModel.outDidTapMovie
            .compactMap { [weak self] movie in
                self?.coordinateToMovieDetail(with: movie.id)
            }
            .flatMap { $0 }
            .bind(to: homeVC.viewModel.outLastViewedId)
            .disposed(by: rx.disposeBag)
        
        return Observable.never()
    }
    
}

extension HomeCoordinator {
    
    private func coordinateToMovieDetail(with movieId: Int) -> Observable<Int> {
        let movieDetailCoordinator = MovieDetailCoordinator(nav: nav, movieId: movieId)
        return coordinate(to: movieDetailCoordinator).compactMap { $0 }
    }
    
}
