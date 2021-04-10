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

class HomeViewModel {
    
    let disposedBag = DisposeBag()
    let network = Network(configuration: NetworkConfiguration(baseURL: MOVIE_URL))
    let movieService: MovieServiceType
    
    init() {
        movieService = MovieService(network: network)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.movieService.fetchPopularMovies().asObservable().subscribe(onNext: { movies in
                print(movies.count)
            }).disposed(by: self.disposedBag)
            
        }
    }
    
}
