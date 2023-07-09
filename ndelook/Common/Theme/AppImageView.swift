//
//  AppImageView.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

class AppImageView: UIImageView {
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        applyCornerRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyCornerRadius()
    }
    
    private func applyCornerRadius() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
