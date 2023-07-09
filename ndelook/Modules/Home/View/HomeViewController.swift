//
//  HomeViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

class HomeViewController: NiblessViewController {
    internal let presenter: HomePresenter
    private var cancellables = Set<AnyCancellable>()
    internal var sectionData: [HomeSection: Any] = [:]
    
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
        view.register(GenreViewCell.self, forCellWithReuseIdentifier: GenreViewCell.identity)
        view.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.identity)
        return view
    }()
    
    init(presenter: HomePresenter) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension HomeViewController {
    private func setupObservers() {
        presenter
            .$sectionData
            .sink { [weak self] value in
                self?.sectionData = value
                self?.sectionViews.reloadData()
            }
            .store(in: &cancellables)
    }
}
