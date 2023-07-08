//
//  AppTheme.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

enum AppTextStyle {
    case normal
    case normalSemiBold
    case textButton
}

struct AppTextAttributes {
    var textColor: UIColor?
    var fontSize: CGFloat?
    var fontWeight: UIFont.Weight?
}

class AppTheme {
    static func textStyle(forType type: AppTextStyle, attributes: AppTextAttributes) -> [NSAttributedString.Key: Any] {
        
        var textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: attributes.textColor ?? .primaryColor
        ]
        
        switch type {
        case .normal:
            textAttributes[.font] = UIFont.systemFont(ofSize: attributes.fontSize ?? 16, weight: attributes.fontWeight ?? .regular)
        case .normalSemiBold:
            textAttributes[.font] = UIFont.systemFont(ofSize: attributes.fontSize ?? 16, weight: attributes.fontWeight ?? .semibold)
        case .textButton:
            textAttributes[.font] = UIFont.systemFont(ofSize: attributes.fontSize ?? 16, weight: attributes.fontWeight ?? .semibold)
            textAttributes[.foregroundColor] = UIColor.white
        }
        
        return textAttributes
    }
    
    static let primaryColor = UIColor.primaryColor
    static let titleColor = UIColor.label
    static let subtitleColor = UIColor.secondaryLabel
}
