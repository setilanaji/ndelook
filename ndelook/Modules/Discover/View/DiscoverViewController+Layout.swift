//
//  DiscoverViewController+Layout.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SnapKit

extension DiscoverViewController {
    override func constructHierarchy() {
        view.addSubview(backdropContainer)
        backdropContainer.addSubview(backdropImage)
        backdropContainer.addSubview(backdropView)
        view.addSubview(sectionViews)
        sectionViews.collectionViewLayout = createLayout()
    }
    
    override func activateConstraints() {
        backdropContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.width).multipliedBy(1)
        }
        
        backdropImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backdropView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        sectionViews.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(view.snp.topMargin)
        }
    }
}
