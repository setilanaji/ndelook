//
//  GetUpcomingMoviesInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetUpcomingMoviesUsecase: Usecase
where Input == Void,
      Output == BaseDomain<[MovieDiscoverDomain]>,
      Failure == ErrorModel {}


final class GetUpcomingMoviesInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetUpcomingMoviesInteractor: GetUpcomingMoviesUsecase {
    func execute(_ input: Void = ()) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        movieRepository.getUpcomingMovies(request: GetMoviesUpcomingRequestModel())
    }
}

