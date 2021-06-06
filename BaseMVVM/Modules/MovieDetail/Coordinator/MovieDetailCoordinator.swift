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

class MovieDetailCoordinator: BaseCoordinator {
    
    let navController: UINavigationController?
    let movieId: Int
    
    init(nav: UINavigationController?, movieId: Int, parent: BaseCoordinator) {
        self.navController = nav
        self.movieId = movieId
        super.init(parent: parent)
    }
    
    override func start() {
        let viewController = Assembler.resolve(MovieDetailViewController.self, argument: movieId)!
        navController?.pushViewController(viewController, animated: true)
        
        viewController.viewModel.didClose
            .subscribe(onNext: { [weak self] id in
                guard let self = self else { return }
                self.navController?.popViewController(animated: true)
                if let id = id {
                    self.didFinish(with: [self.resultKey: id])
                } else {
                    self.didFinish(with: nil)
                }
            }).disposed(by: rx.disposeBag)
    }
    
}
