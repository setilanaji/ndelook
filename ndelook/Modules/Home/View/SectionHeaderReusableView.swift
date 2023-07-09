//
//  SectionHeaderReusableView.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SnapKit

class SectionHeaderReusableView: NiblessReusableView {
    private lazy var sectionTitleLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold)
        return label
    }()
    
    func setup(title: String) {
        sectionTitleLabel.text = title
    }
}

extension SectionHeaderReusableView {
    override func constructHierarchy() {
        addSubview(sectionTitleLabel)
    }
    
    override func activateConstraints() {
        sectionTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
