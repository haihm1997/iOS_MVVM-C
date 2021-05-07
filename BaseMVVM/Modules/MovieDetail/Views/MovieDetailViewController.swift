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
        self.view.addSubview(collectionView)

        collectionView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
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
    }

}
