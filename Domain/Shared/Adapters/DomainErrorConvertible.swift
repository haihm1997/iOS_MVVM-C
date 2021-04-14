//
//  DomainErrorConvertible.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 13/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public protocol DomainErrorConvertible {
    func asDomainError() -> ProjectError
}
