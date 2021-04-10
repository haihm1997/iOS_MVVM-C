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
import WebKit

class HomeViewController: UIViewController {
    
    let webView = WKWebView()
    
    let viewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubviews(webView)
        
        self.webView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: "https://www.google.com.vn/")!))
    }

}
