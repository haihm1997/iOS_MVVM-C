//
//  BlockUseCase.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 03/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift

enum BlockType {
    case movies
    case starShip(query: String)
    
    var query: String? {
        switch self {
        case .movies:
            return nil
        case .starShip(let query):
            return query
        }
    }
}

protocol BlockUseCaseType {
    func fetchBlocks() -> Observable<[BlockType]>
}

class BlockUseCase: BlockUseCaseType {
    
    // Dependencies
    
    init() {
        // init dependencies (ex: repository) in here
    }
    
    func fetchBlocks() -> Observable<[BlockType]> {
        // Do anything (ex: fetch user default data) before call api to get blocks
        return Observable.just([.movies, .starShip(query: "a"), .movies, .starShip(query: "b"), .movies, .starShip(query: "c"), .starShip(query: "d")])
    }
    
}
