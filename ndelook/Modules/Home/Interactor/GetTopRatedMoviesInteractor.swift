//
//  GetTopRatedMoviesInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetTopRatedMoviesUsecase: Usecase
where Input == Void,
      Output == BaseDomain<[MovieDiscoverDomain]>,
      Failure == ErrorModel {}


final class GetTopRatedMoviesInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetTopRatedMoviesInteractor: GetTopRatedMoviesUsecase {
    func execute(_ input: Void = ()) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        movieRepository.getTopRatedMovies(request: GetMoviesTopRatedRequestModel())
    }
}
