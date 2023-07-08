//
//  AppLabel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

class AppLabel: UILabel {
    var textStyle: AppTextStyle = .normal {
        didSet {
            applyStyle()
        }
    }
    
    var boldKey: String? {
        didSet {
            applyStyle()
        }
    }
    
    var textAttributesCallback: (() -> AppTextAttributes?)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
    }
    
    convenience init(textStyle: AppTextStyle, textAttributesCallback: (() -> AppTextAttributes?)? = nil) {
        self.init(frame: .zero)
        self.textStyle = textStyle
        self.textAttributesCallback = textAttributesCallback
    }
    
    override var text: String? {
        didSet {
            applyStyle()
        }
    }
    
    private func applyStyle() {
        guard let labelText = text else { return }
        
        let textAttributes = textAttributesCallback?() ?? AppTextAttributes()
        let attributes = AppTheme.textStyle(forType: textStyle, attributes: textAttributes)
        
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.setAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
        
        if let boldKey = boldKey {
            let range = (labelText.lowercased() as NSString).range(of: boldKey.lowercased())
            attributedText.setAttributes([
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: (attributes[.font] as? UIFont)?.pointSize ?? UIFont.systemFontSize)],
                                         range: range)
        }
        
        self.attributedText = attributedText
    }
}
