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
    
    init(injector: MovieInjectorType) {
        super.init()
        injector.getMovieService().fetchPopularMovies().asObservable().bind(to: outMovies).disposed(by: rx.disposeBag)
    }
    
}
