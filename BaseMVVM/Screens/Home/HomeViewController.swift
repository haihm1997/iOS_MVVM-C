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
import RxSwift
import NSObject_Rx

class HomeViewController: BaseViewController {
    
    let tableView = configure(UITableView()) {
        $0.indicatorStyle = .default
    }
    var viewModel: HomeViewModel!
        
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubviews(tableView)
        
        self.tableView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outMovies.subscribe(onNext: { movies in
            print("HomeViewController: \(movies.count)")
        }).disposed(by: rx.disposeBag)
        viewModel.outError.bind(to: ErrorHandler.defaultAlertBinder(from: self)).disposed(by: rx.disposeBag)
    }

}
