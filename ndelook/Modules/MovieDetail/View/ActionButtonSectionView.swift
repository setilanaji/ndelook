//
//  AuctionButtonSectionView.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit
import SnapKit

class AuctionButtonSectionView: NiblessView {
    var buttons: [IconButton.IconButtonType] = [] {
        didSet {
            applyContent()
        }
    }
    
    var buttonDelegate: IconButtonDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttons = IconButton.IconButtonType.allCases
    }
    
    func applyContent() {
        contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.forEach { item in
            let view = IconButton()
            view.delegate = buttonDelegate
            view.type = item
            view.snp.makeConstraints {
                $0.width.equalTo(64)
            }
            contentStack.addArrangedSubview(view)
        }
        contentStack.layoutIfNeeded()
    }
}

extension AuctionButtonSectionView {
    override func constructHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(contentStack)
    }
    
    override func activateConstraints() {
        scrollView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.top.equalTo(snp.topMargin)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height)
        }
        
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
}
