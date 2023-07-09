//
//  UIImageView+Extension.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImage(with image: String, placeholderImage: UIImage? = UIImage(named: "imgNoImage"), showLoadingIndicator: Bool = true) {
        let urlString = NetworkConstant.shared.getValue(forKey: .baseImage) + ImageResourceHelper.getRemoteImagePathFor(image: image)

        if showLoadingIndicator {
            sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
        sd_setImage(with: URL(string: urlString), placeholderImage: placeholderImage, options: [])
    }
}

extension UIImageView {
    func overlayColorWithOpacity(color: UIColor, opacity: CGFloat) {
        let overlayView = UIView(frame: bounds)
        overlayView.backgroundColor = color
        overlayView.alpha = opacity
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             
        addSubview(overlayView)
    }
}
