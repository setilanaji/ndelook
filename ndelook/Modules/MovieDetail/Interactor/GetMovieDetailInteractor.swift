//
//  GetMovieDetailInteractor.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine


protocol GetMovieDetailUsecase: Usecase
where Input == Int,
      Output == MovieDetailDomain,
      Failure == ErrorModel {}


final class GetMovieDetailInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetMovieDetailInteractor: GetMovieDetailUsecase {
    func execute(_ input: Int) -> AnyPublisher<MovieDetailDomain, ErrorModel> {
        movieRepository.getMovieDetail(request: GetMovieDetailRequestModel(movieId: input))
    }
}
