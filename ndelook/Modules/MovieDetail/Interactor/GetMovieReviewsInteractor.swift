//
//  GetMovieReviewsInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetMovieReviewsUsecase: Usecase
where Input == Int,
      Output == BaseDomain<[ReviewDomain]>,
      Failure == ErrorModel {}


final class GetMovieReviewsInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetMovieReviewsInteractor: GetMovieReviewsUsecase {
    func execute(_ input: Int) -> AnyPublisher<BaseDomain<[ReviewDomain]>, ErrorModel> {
        movieRepository.getMovieReviews(request: GetMovieReviewsRequestModel(movieId: input))
    }
}
