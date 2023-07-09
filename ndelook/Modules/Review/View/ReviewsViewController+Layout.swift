//
//  ReviewsViewController+Layout.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit
import SnapKit

extension ReviewsViewController {
    override func constructHierarchy() {
        view.addSubview(sectionViews)
        sectionViews.collectionViewLayout = createLayout()
    }
    
    override func activateConstraints() {
        sectionViews.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
