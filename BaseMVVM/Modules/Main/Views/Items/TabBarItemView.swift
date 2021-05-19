//
//  TabBarItemView.swift
//  SmartPOS
//
//  Created by Hoang Hai on 10/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

class TabBarItemView: UIView {
    
    private static let width = Constant.Size.screenWidth / 5 // 5 items in Tab Bar view
    
    static let rect: CGRect = CGRect(x: 0, y: 0, width: width, height: Constant.Size.screenHeight)
    
    private var imageViewTopConstraint: NSLayoutConstraint!
    
    private var isSetupTap: Bool = false
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var animated: Bool = false {
        didSet {
            duration = animated ? 0.7 : 0.0
        }
    }
    private var duration: TimeInterval = 0.0
    private var isActive: Bool = false {
        didSet {
            if isActive == oldValue {
                return
            }
            imageViewTopConstraint.constant = self.isActive ? 6 : 16
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
                self.iconImageView.isHidden = !self.isActive
                self.titleLabel.isHidden = !self.isActive
                self.defaultIconImageView.isHidden = self.isActive
            }) { (isFinished) in
                if (self.isActive && self.animated) {
                    self.iconImageView.layer.add(self.bounceAnimation, forKey: nil)
                }
            }
        }
    }
    
    var icon: UIImage? {
        didSet {
            defaultIconImageView.image = icon
            iconImageView.image = icon
        }
    }
        
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var badgeNumber: Int = 0 {
        didSet {
            badgeView.badgeNumber = badgeNumber
        }
    }
    
    var tabItemType: SmartPOSTabBarItemType!
    
    var singleTap = PublishRelay<Int>()
    var doubleTap = PublishRelay<Int>()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        imageView.tintColor = UIColor.primary
        return imageView
    }()
    
    private var defaultIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        label.textColor = UIColor("#eb1f3a")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var badgeView: BadgeView = {
        let badge = BadgeView()
        badge.badgeNumber = 0
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
            
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
        contentView.addSubview(defaultIconImageView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(badgeView)
        
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageViewTopConstraint = iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        imageViewTopConstraint.isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        defaultIconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        defaultIconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        defaultIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        defaultIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor, constant: 0).isActive = true
        
        badgeView.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -5.0).isActive = true
        badgeView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -9.0).isActive = true
        
    }
    
    private func commonInit() {
        addSubviews()
        if !isSetupTap {
            setupTaps()
        }
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        animation.duration = TimeInterval(0.3)
        animation.calculationMode = CAAnimationCalculationMode.cubic
        return animation
    }()
    
    func active(_ active: Bool, animated: Bool = false) {
        self.animated = animated
        isActive = active
    }
    
    // MARK: - taps
    private func setupTaps() {
        self.contentView.isUserInteractionEnabled = true
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.contentView.addGestureRecognizer(doubleTap)
        doubleTap.cancelsTouchesInView = false

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(didSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        self.contentView.addGestureRecognizer(singleTap)
        singleTap.cancelsTouchesInView = false
        
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2

        let singleTapGesture = UITapGestureRecognizer()
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.require(toFail: doubleTapGesture)
        
        isSetupTap = true
    }
    
    @objc private func didSingleTap(_ recognizer: UIGestureRecognizer) {
        singleTap.accept(badgeNumber)
    }
    
    @objc private func didDoubleTap(_ recognizer: UIGestureRecognizer) {
        doubleTap.accept(badgeNumber)
    }

}

