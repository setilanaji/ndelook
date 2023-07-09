//
//  IconButton.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit
import SnapKit

protocol IconButtonDelegate: AnyObject {
    func onTap(_ type: IconButton.IconButtonType)
}

class IconButton: NiblessView {
    
    var delegate: IconButtonDelegate?
    
    enum IconButtonType: Int, CaseIterable {
        case review
        case share
        
        var iconAssetName: String {
            switch self {
            case .share:
                return "square.and.arrow.up"
            case .review:
                return "quote.bubble"
            }
        }
        
        var text: String {
            switch self {
            case .review:
                return "Reviews"
            case .share:
                return "Share"
            }
        }
    }
    
    var type: IconButtonType = .review {
        didSet {
            applyIcon()
            applyText()
        }
    }
    
    var text: String = "" {
        didSet {
            applyText()
            applyIcon()
        }
    }
    
    private lazy var icon: AppImageView = {
        let view = AppImageView()
        return view
    }()
    
    private lazy var textLabel: AppLabel = {
        let label = AppLabel(textStyle: .normal) {
            var attr = AppTextAttributes()
            attr.fontSize = 13
            attr.textColor = .secondaryLabel
            return attr
        }
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyIcon()
        applyText()
    }
    
    private func applyIcon() {
        icon.image = UIImage(systemName: type.iconAssetName)?.withRenderingMode(.alwaysTemplate).withTintColor(.label)
    }
    
    private func applyText() {
        textLabel.text = text.isEmpty ? type.text : text
    }
}

extension IconButton {
    override func constructHierarchy() {
        addSubview(icon)
        addSubview(textLabel)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }
    
    override func activateConstraints() {
        icon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
    
    @objc
    private func onTap(_ sender: Any?) {
        delegate?.onTap(self.type)
    }
}
