//
//  ReviewViewCell.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit
import SnapKit

class ReviewViewCell: NiblessCollectionViewCell {
    private lazy var userNameLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold)
        return label
    }()
    
    private lazy var postedDateLabel: AppLabel = {
        let label = AppLabel(textStyle: .normal) {
            var attr = AppTextAttributes()
            attr.textColor = .secondaryLabel
            attr.fontSize = 13
            return attr
        }
        return label
    }()
    
    private lazy var contentLabel: AppLabel = {
        let label = AppLabel(textStyle: .normal) {
            var attr = AppTextAttributes()
            attr.fontSize = 13
            return attr
        }
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var avatarImage: AppImageView = {
        let view = AppImageView()
        view.cornerRadius = 16
        return view
    }()
    
    func setup(review: ReviewDomain) {
        avatarImage.loadImage(with: review.authorDetails.avatarPath, placeholderImage: UIImage(systemName: "person.circle.fill"))
        userNameLabel.text = review.author
        contentLabel.text = review.content
        postedDateLabel.text = review.postDate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLineBorder()
    }
}

extension ReviewViewCell {
    override func constructHierarchy() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(postedDateLabel)
        contentView.addSubview(contentLabel)
    }
    
    override func activateConstraints() {
        avatarImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(32)
            $0.width.equalTo(32)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImage.snp.trailing).offset(8)
            $0.centerY.equalTo(avatarImage.snp.centerY)
        }
        
        postedDateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(avatarImage.snp.centerY)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImage.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
