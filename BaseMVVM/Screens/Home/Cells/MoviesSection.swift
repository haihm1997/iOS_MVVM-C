//
//  MoviesSection.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 22/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesSection: BaseCollectionViewCell {

    private lazy var collectionView: UICollectionView = {
        let layout = CommonHorizontalFlowLayout()
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.className)
        return collectionView
    }()
    
    var viewModel: MovieSectionViewModel!
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
    
    func bind(_ viewModel: MovieSectionViewModel) {
        self.viewModel = viewModel
        
        Observable.just(viewModel.data).bind(to: collectionView.rx.items(cellIdentifier: MovieCell.className, cellType: MovieCell.self)) {
            _, item, cell in
            cell.bind(movie: item)
        }.disposed(by: disposeBag)
    }
    
}

class MovieCell: BaseCollectionViewCell {
    
    let backgroundImg = configure(UIImageView()) {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .orange
    }
    
    let titleLabel = configure(UILabel()) {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }
    
    let releaseLabel = configure(UILabel()) {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let vote = configure(UILabel()) {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let movieContainerView = configure(UIView()) {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .white
    }
    
    let stackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 2
    }
    
    override func setupViews() {
        super.setupViews()
        
        stackView.addArrangedSubviews(titleLabel, releaseLabel, vote)
        
        movieContainerView.addSubviews(backgroundImg, stackView)
        self.contentView.addSubview(movieContainerView)
        
        movieContainerView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundImg.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalToSuperview().inset(8)
            maker.height.equalTo(128)
        }
        
        stackView.snp.makeConstraints { (maker) in
            maker.top.equalTo(backgroundImg.snp.bottom).offset(8)
            maker.trailing.leading.equalToSuperview().inset(8)
        }
    }
    
    func bind(movie: Movie) {
        backgroundImg.setImageByKF(imageURL: movie.imageUrl)
        titleLabel.text = movie.title
        releaseLabel.text = movie.releaseDate
        vote.text = "Vote: \(movie.vote)"
    }
    
}
