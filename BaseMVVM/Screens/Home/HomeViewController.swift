//
//  HomeViewController.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 9/19/20.
//  Copyright © 2020 TonyHoang. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa

class HomeViewController: UIViewController {
    
    let centerLabel = configure(UILabel()) { label in
        label.text = "Center Label"
        label.textColor = .blue
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubviews(centerLabel)
        
        centerLabel.snp.makeConstraints { (maker) in
            maker.center.equalTo(view.center)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

}
