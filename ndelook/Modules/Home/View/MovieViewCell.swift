//
//  MovieViewCell.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SnapKit

class MovieViewCell: AppCollectionViewCell {
    private lazy var posterImage: AppImageView = {
        let view = AppImageView()
        view.cornerRadius = 5
        return view
    }()
    
    private lazy var titleLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold) {
            var attr = AppTextAttributes()
            attr.fontSize = 14
            return attr
        }
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        addLongPressAnimation()
    }
    
    func setupMovie(_ movie: MovieDiscoverDomain) {
        posterImage.loadImage(with: movie.posterPath)
        titleLabel.text = movie.title
    }
}

extension MovieViewCell {
    override func constructHierarchy() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
    }
    
    override func activateConstraints() {
        posterImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(posterImage.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(posterImage.snp.bottom).offset(8)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
}
