//
//  ViewController+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/19/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func configure<T>(
        _ value: T,
        using closure: (inout T) throws -> Void
    ) rethrows -> T {
        var value = value
        try closure(&value)
        return value
    }
    
}
