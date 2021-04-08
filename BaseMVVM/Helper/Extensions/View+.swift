//
//  View+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/19/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import UIKit

extension UIView {
    
    static func configure<T>(
        _ value: T,
        using closure: (inout T) throws -> Void
    ) rethrows -> T {
        var value = value
        try closure(&value)
        return value
    }
    
    func addSubviews<S: Sequence>(_ subviews: S) where S.Iterator.Element: UIView {
        subviews.forEach(self.addSubview(_:))
    }
    
    func addSubviews(_ subviews: UIView...) {
        self.addSubviews(subviews)
    }
    
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
}
