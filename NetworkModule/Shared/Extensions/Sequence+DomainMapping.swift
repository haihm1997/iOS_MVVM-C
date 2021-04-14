//
//  Sequence+DomainMapping.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 13/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

extension Array: DomainConvertible where Element: DomainConvertible {
    public func asDomain() -> Array<Element.DomainType> {
        return map { $0.asDomain() }
    }
}
