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
    
    let window: UIWindow?
    var nav: UINavigationController?
    
    public init(window: UIWindow?) {
        self.window = window
    }
    
    public override func start() -> Observable<Void> {
        let homeVC = Assembler.resolve(HomeViewController.self)!
        let nav = UINavigationController(rootViewController: homeVC)
        self.nav = nav
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        homeVC.viewModel.outDidTapMovie
            .map({ [unowned self] movie in
                self.coordinateToMovieDetail(with: movie.id)
            })
            .subscribe()
            .disposed(by: rx.disposeBag)
        
        return Observable.never()
    }
    
}

extension HomeCoordinator {
    
    private func coordinateToMovieDetail(with movieId: Int) -> Observable<Int?> {
        let movieDetailCoordinator = MovieDetailCoordinator(nav: nav, movieId: movieId)
        return coordinate(to: movieDetailCoordinator)
    }
    
}
