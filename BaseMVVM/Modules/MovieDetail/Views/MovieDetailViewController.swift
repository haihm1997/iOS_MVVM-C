//
//  MovieDetailViewController.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 06/05/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import SnapKit
import RxSwift

class MovieDetailViewController: BaseViewController {
    
    let navigationView = configure(MyNavigationView()) {
        $0.title = "Movie Detail"
    }

    private lazy var collectionView: UICollectionView = {
        let layout = MovieDetailFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieAttributeCell.self, forCellWithReuseIdentifier: MovieAttributeCell.className)
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        return collectionView
    }()
    var viewModel: MovieDetailViewModel!
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.view.addSubviews(collectionView, navigationView)
        
        navigationView.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeAreaLayoutGuide)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(56)
        }
        
        self.collectionView.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.outAttributes.bind(to: collectionView.rx.items(cellIdentifier: MovieAttributeCell.className, cellType: MovieAttributeCell.self)) {
            _, item, cell in
            cell.bind(attribute: item)
        }.disposed(by: rx.disposeBag)
        navigationView.leftAction.withLatestFrom(Observable.just(viewModel.movieId)).bind(to: viewModel.didClose).disposed(by: rx.disposeBag)
    }

}
