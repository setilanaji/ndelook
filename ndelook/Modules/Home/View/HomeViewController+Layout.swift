//
//  HomeViewController+Layout.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SnapKit

extension HomeViewController {
    override func constructHierarchy() {
        view.addSubview(sectionViews)
        
        sectionViews.collectionViewLayout = createLayout()
    }
    
    override func activateConstraints() {
        sectionViews.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
