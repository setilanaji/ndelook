//
//  UIViewController+Layout.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

@objc
extension UIViewController {
    func setupSubviews() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {}
    func activateConstraints() {}
}

extension UIViewController {
    var screenWidth: CGFloat {
        self.view.window?.screen.screenWidth ?? 0
    }
}
