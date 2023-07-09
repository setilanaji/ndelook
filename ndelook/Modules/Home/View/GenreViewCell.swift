//
//  GenreViewCell.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SnapKit

class GenreViewCell: AppCollectionViewCell {
    private lazy var titleLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold) {
            var attr = AppTextAttributes()
            attr.fontSize = 14
            return attr
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        addLongPressAnimation()
    }
    
    func setup(genre: GenreDomain) {
        titleLabel.text = genre.name
    }
}

extension GenreViewCell {
    override func constructHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    override func activateConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().offset(-4)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
