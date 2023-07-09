//
//  ReviewsViewController.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import UIKit
import Combine

class ReviewsViewController: NiblessViewController {
    internal let presenter: ReviewsPresenter
    private var cancellables = Set<AnyCancellable>()
    internal var reviews = [ReviewDomain]()
    
    internal let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    internal lazy var sectionViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.contentInsetAdjustmentBehavior = .never
        view.showsVerticalScrollIndicator = false
        view.register(ReviewViewCell.self, forCellWithReuseIdentifier: ReviewViewCell.identity)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupObservers()
        
        presenter.viewEventSubject.send(.viewDidLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init(presenter: ReviewsPresenter) {
        self.presenter = presenter
        super.init()
    }
}

extension ReviewsViewController {
    private func setupObservers() {
        presenter.$reviews
            .sink { [weak self] value in
                self?.reviews = value
                self?.title = value.count.toString() + " Reviews"
                self?.sectionViews.reloadData()
            }
            .store(in: &cancellables)
        
        presenter
            .$isLoading
            .sink { [weak self] value in
                if value && (self?.reviews.isEmpty ?? false) {
                    self?.showLoadingIndicator()
                } else {
                    self?.hideLoadingIndicator()
                }
            }
            .store(in: &cancellables)
    }
    
    private func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
    }
}
