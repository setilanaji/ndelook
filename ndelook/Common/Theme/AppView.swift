//
//  AppView.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

class AppView: UIView {
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyCornerRadius()
        backgroundColor = .backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyCornerRadius()
        backgroundColor = .backgroundColor
    }
    
    private func applyCornerRadius() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
