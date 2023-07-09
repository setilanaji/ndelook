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
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(sectionViews)
        view.addSubview(loadingIndicator)
        sectionViews.collectionViewLayout = createLayout()
    }
    
    override func activateConstraints() {
        sectionViews.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(view.snp.topMargin)
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
