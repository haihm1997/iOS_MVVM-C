//
//  MovieDetailCoordinator.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 07/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

class MovieDetailCoordinator: ReactiveCoordinator<Int?> {
    
    let navController: UINavigationController?
    let movieId: Int
    
    init(nav: UINavigationController?, movieId: Int) {
        self.navController = nav
        self.movieId = movieId
    }
    
    override func start() -> Observable<Int?> {
        let viewController = Assembler.resolve(MovieDetailViewController.self, argument: movieId)!
        navController?.pushViewController(viewController, animated: true)
        return viewController.viewModel.didClose.debug().do(onNext: { [weak self] _ in
            self?.navController?.popViewController(animated: true)
        }).asObservable()
    }
    
}
