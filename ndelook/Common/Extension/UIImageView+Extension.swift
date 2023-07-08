//
//  UIImageView+Extension.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

extension UIImageView {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    public func loadImage(from urlString: String, placeholder: UIImage? = nil, completion: (() -> Void)? = nil) {
        self.image = placeholder
        
        guard let url = URL(string: urlString) else {
            completion?()
            return
        }
        
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion?()
            return
        }
        
        loadImage(from: url, completion: completion)
    }
    
    private func loadImage(from url: URL, completion: (() -> Void)?) {
        guard UIApplication.shared.canOpenURL(url) else {
            completion?()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion?()
                return
            }
            
            if let image = UIImage(data: data) {
                UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self?.image = image
                    completion?()
                }
            } else {
                completion?()
            }
        }.resume()
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
