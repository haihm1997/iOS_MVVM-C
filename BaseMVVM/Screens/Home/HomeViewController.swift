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
import RxDataSources

enum HomeSectionIdentifier: String, CaseIterable {
    case movies
    case starships

    static func identifider(for section: HomeSection) -> HomeSectionIdentifier {
        switch section {
        case .movies:
            return .movies
        case .starships:
            return .starships
        }
    }
    
    var cellType: BaseCollectionViewCell.Type {
        switch self {
        case .movies:
            return MoviesSection.self
        case .starships:
            return StarShipSection.self
        }
    }
    
}

class HomeViewController: BaseViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = HomeCollectionFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        HomeSectionIdentifier.allCases.forEach { collectionView.register($0.cellType, forCellWithReuseIdentifier: $0.rawValue) }
        return collectionView
    }()
    var viewModel: HomeViewModel!
    private typealias Section = SectionModel<String, HomeSection>
    private typealias DataSource = RxCollectionViewSectionedReloadDataSource<Section>
    private lazy var dataSource = self.createDataSource()
        
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubviews(collectionView)
        
        self.collectionView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.outAllSections.map { [Section(model: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        viewModel.outError.bind(to: ErrorHandler.defaultAlertBinder(from: self)).disposed(by: rx.disposeBag)
        viewModel.outActivity.bind(to: loadingBinder).disposed(by: rx.disposeBag)
    }

    private func createDataSource() -> DataSource {
        let dataSource = DataSource (configureCell: { (_, collectionView, indexPath, section) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSectionIdentifier.identifider(for: section).rawValue, for: indexPath)
            
            switch section {
            case .movies(let viewModel):
                (cell as! MoviesSection).bind(viewModel)
            case .starships(let viewModel):
                (cell as! StarShipSection).bind(viewModel)
            }
            return cell
        })
        
        return dataSource
    }
    
}
