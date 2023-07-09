//
//  GetMovieReviewsInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetMovieReviewsUsecase: Usecase
where Input == PaginationRequestProtocol,
      Output == BaseDomain<[ReviewDomain]>,
      Failure == ErrorModel {}


final class GetMovieReviewsInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetMovieReviewsInteractor: GetMovieReviewsUsecase {
    func execute(_ input: PaginationRequestProtocol) -> AnyPublisher<BaseDomain<[ReviewDomain]>, ErrorModel> {
        guard let request = input as? PaginationRequest else {
            return Fail(error: ErrorModel(message: "Wrong request")).eraseToAnyPublisher()
        }
        return movieRepository.getMovieReviews(request: GetMovieReviewsRequestModel(movieId: request.movieId, page: request.page))
    }
}
