//
//  UIView+Extension.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit

extension UIView {
    func addLineBorder(cornerRadius: CGFloat = 5, borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor) {
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        self.clipsToBounds = true
    }
}
