//
//  StarWarUserCase.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 03/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift

protocol StarWarUserCaseType {
    func fetchStarships(by name: String) -> Observable<[StarShip]>
}

class StarWarUserCase: StarWarUserCaseType {
    
    let starWarInjector: StarWarInjectorType
    
    init(injector: StarWarInjectorType) {
        self.starWarInjector = injector
    }
    
    func fetchStarships(by name: String) -> Observable<[StarShip]> {
        // do anything before call api (ex: contruct request data)
        return starWarInjector.getStarWarService().fetchStarships(by: name).asObservable()
    }
    
}
