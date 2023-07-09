//
//  NiblessReusableView.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

open class NiblessReusableView: UICollectionReusableView {
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    @available(*, unavailable, message: "Unsupported")
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
}
