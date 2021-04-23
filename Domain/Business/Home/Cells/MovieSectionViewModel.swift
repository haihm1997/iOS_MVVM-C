//
//  MovieSectionViewModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift

class MovieSectionViewModel: BaseViewModel {
    
    let data: [Movie]
    
    init(data: [Movie]) {
        self.data = data
    }
    
}
