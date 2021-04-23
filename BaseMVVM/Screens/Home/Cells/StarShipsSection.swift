//
//  StarShipsSection.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StarShipSection: BaseCollectionViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let layout = CommonHorizontalFlowLayout()
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(StarShipCell.self, forCellWithReuseIdentifier: StarShipCell.className)
        return collectionView
    }()
    
    var viewModel: StarWarSectionViewModel!
    var disposeBag = DisposeBag()
    
    override func setupViews() {
        super.setupViews()
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bind(_ viewModel: StarWarSectionViewModel) {
        self.viewModel = viewModel
        
        Observable.just(viewModel.data).bind(to: collectionView.rx.items(cellIdentifier: StarShipCell.className, cellType: StarShipCell.self)) {
            _, item, cell in
            cell.bind(item)
        }.disposed(by: disposeBag)
    }
    
}

class StarShipCell: BaseCollectionViewCell {
    
    let nameLabel = configure(UILabel()) {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    let modelLabel = configure(UILabel()) {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    let costLabel = configure(UILabel()) {
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    let filmsLabel = configure(UILabel()) {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 2
    }
    
    let starShipContainerView = configure(UIView()) {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    let stackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 2
    }
    
    override func setupViews() {
        super.setupViews()
        stackView.addArrangedSubviews(nameLabel, modelLabel, costLabel, filmsLabel)
        
        starShipContainerView.addSubviews(stackView)
        
        self.contentView.addSubview(starShipContainerView)
        
        starShipContainerView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.leading.trailing.equalToSuperview().inset(8)
        }
        
    }
    
    func bind(_ starship: StarShip) {
        nameLabel.text = starship.name
        modelLabel.text = starship.model
        costLabel.text = starship.cost
        filmsLabel.text = starship.films.joined(separator: ", ")
    }
    
}
