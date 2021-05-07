//
//  MovieSectionViewModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MovieSectionViewModel: BaseViewModel {
    
    var data: [Movie]
    
    // Input
    var inDidTapCell = PublishRelay<Movie>()
    
    init(data: [Movie]) {
        self.data = data
        super.init()
    }
    
}
