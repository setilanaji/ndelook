//
//  MovieDetailRouter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

enum MovieDetailDestination {
    case toReviews(Int)
}

protocol MovieDetailWireframe: Wireframe where Destination == MovieDetailDestination {}

class MovieDetailRouter: MovieDetailWireframe {
    private var cancellables = Set<AnyCancellable>()
    let navigationSubject = PassthroughSubject<MovieDetailDestination, Never>()
    internal weak var viewController: MovieDetailViewController?
    
    init() {
        navigationSubject
            .sink { destination in
                switch destination {
                case .toReviews(let movieId):
                    let view = UINavigationController(rootViewController: ReviewsRouter.createModule(movieId: movieId))
                    self.viewController?.present(view, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    static func createModule(
        movieId: Int
    ) -> MovieDetailViewController {
        let router = MovieDetailRouter()
        let movieRepository = RepositoryInjection.provideMovieRepository()
        let movieDetailInteractor = GetMovieDetailInteractor(movieRepository: movieRepository)
        let movieVideosInteractor = GetMovieVideosInteractor(movieRepository: movieRepository)
        let movieReviewsInteractor = GetMovieReviewsInteractor(movieRepository: movieRepository)
        let presenter = MovieDetailPresenter(
            router: router,
            movieDetailInteractor: movieDetailInteractor,
            movieVideosInteractor: movieVideosInteractor,
            movieReviewsInteractor: movieReviewsInteractor,
            movieId: movieId
        )
        let view = MovieDetailViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}
