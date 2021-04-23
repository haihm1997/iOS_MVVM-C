//
//  NSObject+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    
    static var className: String {
        return String(describing: self)
    }
    
}
