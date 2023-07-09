//
//  MovieDetailViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine
import youtube_ios_player_helper

class MovieDetailViewController: NiblessViewController {
    private let presenter: MovieDetailPresenter
    private var cancellables = Set<AnyCancellable>()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private(set) lazy var lineIndicator: NiblessView = {
        let view = NiblessView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .white.withAlphaComponent(0.6)
        return view
    }()
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private(set) lazy var nameLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold) {
            var attr = AppTextAttributes()
            attr.fontSize = 24
            attr.textColor = .white
            return attr
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var infosLabel: AppLabel = {
        let label = AppLabel(textStyle: .normal) {
            var attr = AppTextAttributes()
            attr.fontSize = 10
            attr.textColor = .white
            return attr
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var contentContainer: AppView = {
        let view = AppView()
        view.cornerRadius = 10
        return view
    }()
    
    private(set) lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 16
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    private(set) lazy var dummyContent: NiblessView = {
        let view = NiblessView()
        return view
    }()
    
    private(set) lazy var videoPlayerView: YTPlayerView = {
        let view = YTPlayerView()
        return view
    }()
    
    private(set) lazy var genresLabel: AppLabel = {
        let label = AppLabel(textStyle: .normalSemiBold) {
            var attr = AppTextAttributes()
            attr.fontSize = 10
            return attr
        }
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var checkButton: AppButton = {
        let button = AppButton(textStyle: .normalSemiBold) {
            var attr = AppTextAttributes()
            attr.textColor = .white
            return attr
        }
        button.setTitle("Check Now", for: .normal)
        button.cornerRadius = 10
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTapCheck(_:))))
        return button
    }()
    
    private(set) lazy var buttonSectionView: AuctionButtonSectionView = {
        let view = AuctionButtonSectionView()
        view.buttons = IconButton.IconButtonType.allCases
        view.buttonDelegate = self
        return view
    }()
    
    private(set) lazy var informationSectionView: MovieInformationSectionView = {
        let view = MovieInformationSectionView()
        return view
    }()
    
    init(presenter: MovieDetailPresenter) {
        self.presenter = presenter
        super.init()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setObserver()
        
        presenter.viewEventSubject.send(.viewDidLoad)
    }
}

extension MovieDetailViewController {
    private func setObserver() {
        presenter.$movieDetail
            .sink { [weak self] value in
                guard let movie = value else {
                    return
                }
                self?.setupMovie(movie)
            }
            .store(in: &cancellables)
        
        presenter.$movieTrailer
            .sink { [weak self] value in
                guard let key = value?.key, !key.isEmpty else {
                    return
                }
                let playerVars: [String: Any] = [
                    "autoplay": 1,
                    "playsinline": 1,
                    "controls": 0,
                    "loop": 1
                ]
                self?.videoPlayerView.load(withVideoId: key, playerVars: playerVars)
                self?.videoPlayerView.playVideo()
            }.store(in: &cancellables)
    }
    
    private func setupMovie(_ movie: MovieDetailDomain) {
        nameLabel.text = movie.title
        infosLabel.text = movie.infos
        informationSectionView.setup(genres: movie.genresString, description: movie.overview)
    }
    
    @objc
    private func onTapCheck(_ sender: AppButton) {
        presenter.viewEventSubject.send(.onTapCheck)
    }
}

extension MovieDetailViewController: IconButtonDelegate {
    func onTap(_ type: IconButton.IconButtonType) {
        switch type {
        case .review:
            presenter.viewEventSubject.send(.onTapReviews)
        case .share:
            presenter.viewEventSubject.send(.onTapShare)
        }
    }
}
