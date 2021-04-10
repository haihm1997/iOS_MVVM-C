//
//  DomainConvertible.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 09/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public protocol DomainConvertible {
    associatedtype DomainType
    func asDomain() -> DomainType
}

