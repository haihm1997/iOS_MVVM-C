//
//  BadgeView.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import SnapKit

class BadgeView: UIView {
    private let maxValue: Int = 99
    
    private var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9.0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var badgeValue: String? {
        didSet {
            guard let value = badgeValue, value.isNotEmpty else {
                isHidden = true
                return
            }
            isHidden = false
            valueLabel.text = badgeValue
        }
    }
    
    var badgeNumber: Int = 0 {
        didSet {
            var text: String?
            if badgeNumber > maxValue {
                text = "\(maxValue)+"
            } else if badgeNumber > 0 {
                text = "\(badgeNumber)"
            }
            badgeValue = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(valueLabel)
        
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 18.0)
        heightConstraint.priority = .init(rawValue: 999)
        heightConstraint.isActive = true
        let widthConstraint = contentView.widthAnchor.constraint(greaterThanOrEqualTo: contentView.heightAnchor, multiplier: 1.0)
        widthConstraint.priority = .init(rawValue: 999)
        widthConstraint.isActive = true
        
        valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0).isActive = true
        valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func commonInit() {
        addSubviews()
    }
}
