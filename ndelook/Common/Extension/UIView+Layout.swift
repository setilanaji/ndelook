//
//  UIView+Layout.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

@objc
extension UIView {
    func setupSubviews() {
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {}
    func activateConstraints() {}
}

protocol Identifiable {
    static var identity: String { get }
}

extension UIView: Identifiable {
    static var identity: String {
        return String(describing: self)
    }
}
