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

class HomeCoordinator: BaseCoordinator {
    
    var nav: UINavigationController!
    
    override func start() {
        let homeVC = Assembler.resolve(HomeViewController.self)!
        let nav = UINavigationController(rootViewController: homeVC)
        nav.setNavigationBarHidden(true, animated: false)
        self.nav = nav
        
        homeVC.viewModel.outDidTapMovie
            .map { $0.id }
            .bind(to: openMovieDetailBinder)
            .disposed(by: rx.disposeBag)
        
        removeChildHandler = { [weak self] child, data in
            if let child = child as? MovieDetailCoordinator,
               let id = data?[child.resultKey] as? Int {
                homeVC.viewModel.outLastViewedId.accept(id)
            }
        }
    }
    
}

extension HomeCoordinator {
    
    private var openMovieDetailBinder: Binder<Int> {
        return Binder(self) { target, id in
            let movieDetailCoordinator = MovieDetailCoordinator(nav: target.nav, movieId: id, parent: target)
            target.coordinate(with: movieDetailCoordinator)
        }
    }
    
}
