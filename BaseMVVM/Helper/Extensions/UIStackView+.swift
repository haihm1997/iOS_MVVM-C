//
//  UIStackView+.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews<S: Sequence>(_ subviews: S) where S.Iterator.Element: UIView {
        subviews.forEach(self.addArrangedSubview(_:))
    }
    
    func addArrangedSubviews(_ subviews: UIView...) {
        self.addArrangedSubviews(subviews)
    }
}
