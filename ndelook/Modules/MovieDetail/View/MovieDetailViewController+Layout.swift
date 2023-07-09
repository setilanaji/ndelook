//
//  MovieDetailViewController+Layout.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import SnapKit

extension MovieDetailViewController {
    override func constructHierarchy() {
        scrollView.delegate = self
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(dummyContent)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(infosLabel)
        containerView.addSubview(lineIndicator)
        
        containerView.addSubview(contentContainer)
        contentContainer.addSubview(contentStack)
        contentStack.addArrangedSubview(videoPlayerViw)
        contentStack.addArrangedSubview(checkButton)
        contentStack.addArrangedSubview(informationSectionView)
        contentStack.addArrangedSubview(buttonSectionView)
        
        buttonSectionView.buttons = IconButton.IconButtonType.allCases
    }
    
    override func activateConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
            $0.width.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.width.equalToSuperview()
        }
        
        nameLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.greaterThanOrEqualTo(34)
        }
        
        infosLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        lineIndicator.snp.makeConstraints {
            $0.top.equalTo(infosLabel.snp.bottom).offset(16)
            $0.width.equalTo(48)
            $0.height.equalTo(4)
            $0.centerX.equalToSuperview()
        }
        
        contentContainer.snp.makeConstraints {
            $0.top.equalTo(lineIndicator.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.bottom)
        }
        
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        videoPlayerViw.snp.remakeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(videoPlayerViw.snp.width).multipliedBy(9.0/16.0)
        }
        
        checkButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalTo(contentStack.snp.leading).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        buttonSectionView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        dummyContent.snp.makeConstraints {
            $0.height.equalTo(view.snp.height).multipliedBy(0.6)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -120 {
            dismiss(animated: true, completion: nil)
        }
    }
}
