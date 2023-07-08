//
//  NiblessView.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

open class NiblessView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
    }
    
    @available(*, unavailable, message: "Unsupported")
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

