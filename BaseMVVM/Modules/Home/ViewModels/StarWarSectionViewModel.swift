//
//  StarWarSectionViewModel.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift

class StarWarSectionViewModel: BaseViewModel {
    
    var data: [StarShip]
    
    init(data: [StarShip]) {
        self.data = data
    }
    
}
