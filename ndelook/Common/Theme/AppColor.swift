//
//  AppColor.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

extension UIColor {
    static var backgroundColor: UIColor {
        return UIColor(named: "BackgroundColor") ?? .white
    }
    
    static var primaryColor: UIColor {
        return UIColor(named: "PrimaryColor") ?? .orange
    }
}
