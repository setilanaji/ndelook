//
//  NiblessCollectionViewCell.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

open class NiblessCollectionViewCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        setupSubviews()
    }
    
    @available(*, unavailable, message: "Unsupported")
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
