//
//  Single+DomainMapping.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 13/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation
import RxSwift

extension PrimitiveSequenceType where Trait == SingleTrait, Element: DomainConvertible {
    
    func mapToDomain() -> Single<Element.DomainType> {
        return map { $0.asDomain() }
    }
    
}
