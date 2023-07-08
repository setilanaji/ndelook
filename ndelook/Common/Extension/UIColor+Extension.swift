//
//  UIColor+Extension.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

extension UIColor {
    func darker(by percentage: CGFloat) -> UIColor? {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness -= percentage / 100.0
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        return nil
    }
}
