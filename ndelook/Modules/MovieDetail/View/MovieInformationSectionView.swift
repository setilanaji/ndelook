//
//  MovieInformationSectionView.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit
import SnapKit

class MovieInformationSectionView: NiblessView {
    private lazy var genresLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold) {
            var attr = AppTextAttributes()
            attr.fontSize = 13
            return attr
        }
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: AppLabel = {
        let label = AppLabel(textStyle: .normal) {
            var attr = AppTextAttributes()
            attr.fontSize = 13
            attr.textColor = .secondaryLabel
            return attr
        }
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    func setup(
        genres: String,
        description: String
    ) {
        genresLabel.text = genres
        descriptionLabel.text = description
    }
}

extension MovieInformationSectionView {
    override func constructHierarchy() {
        addSubview(genresLabel)
        addSubview(descriptionLabel)
    }
    
    override func activateConstraints() {
        genresLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.greaterThanOrEqualToSuperview().offset(-16)
            $0.top.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
    }
}
