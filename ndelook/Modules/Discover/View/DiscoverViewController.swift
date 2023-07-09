//
//  DiscoverViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

class DiscoverViewController: NiblessViewController {
    internal let presenter: DiscoverPresenter
    private var cancellables = Set<AnyCancellable>()
    internal var movies = [MovieDiscoverDomain]()
    
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
        view.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.identity)
        return view
    }()
    
    init(presenter: DiscoverPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewEventSubject.send(.viewDidLoad)
    }
}

extension DiscoverViewController {
    private func setupObservers() {
        presenter
            .$movies
            .sink { [weak self] value in
                self?.movies = value
                self?.sectionViews.reloadData()
            }
            .store(in: &cancellables)
        
        presenter
            .$genre
            .sink { [weak self] value in
                self?.title = value
            }
            .store(in: &cancellables)
        
        presenter
            .$isLoading
            .sink { [weak self] value in
                if value && (self?.movies.isEmpty ?? false) {
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
