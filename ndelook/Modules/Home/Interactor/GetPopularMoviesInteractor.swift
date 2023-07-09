//
//  GetPopularMoviesInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetPopularMoviesUsecase: Usecase
where Input == Void,
      Output == BaseDomain<[MovieDiscoverDomain]>,
      Failure == ErrorModel {}


final class GetPopularMoviesInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetPopularMoviesInteractor: GetPopularMoviesUsecase {
    func execute(_ input: Void = ()) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        movieRepository.getPopularMovies(request: GetMoviesPopularRequestModel())
    }
}
