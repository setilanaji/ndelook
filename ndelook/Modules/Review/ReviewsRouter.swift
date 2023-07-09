//
//  ReviewsRouter.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

enum ReviewsDestination {}

protocol ReviewsWireframe: Wireframe where Destination == ReviewsDestination {}

class ReviewsRouter: ReviewsWireframe {
    let navigationSubject = PassthroughSubject<ReviewsDestination, Never>()
    internal weak var viewController: ReviewsViewController?
    
    init() {}
    
    static func createModule(
        movieId: Int
    ) -> ReviewsViewController {
        let router = ReviewsRouter()
        let movieReviewsInteractor = GetMovieReviewsInteractor(movieRepository: RepositoryInjection.provideMovieRepository())
        let presenter = ReviewsPresenter(
            router: router,
            movieReviewsInteractor: movieReviewsInteractor,
            movieId: movieId
        )
        let view = ReviewsViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}
