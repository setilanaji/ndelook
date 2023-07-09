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
    
    private(set) lazy var backdropContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    internal lazy var backdropImage: AppImageView = {
        let view = AppImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private(set) lazy var backdropView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 1
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
                self?.setBackdrop(self?.movies.first)
            }
            .store(in: &cancellables)
        
        presenter
            .$genre
            .sink { [weak self] value in
                self?.title = value
            }
            .store(in: &cancellables)
    }
    
    private func setBackdrop(_ movie: MovieDiscoverDomain?) {
        guard let backdrop = movie?.backdropPath else {
            return
        }
        backdropImage.loadImage(with: backdrop)
    }
}
