//
//  GetNowPlayingInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetNowPlayingMoviesUsecase: Usecase
where Input == Void,
      Output == BaseDomain<[MovieDiscoverDomain]>,
      Failure == ErrorModel {}


final class GetNowPlayingMoviesInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetNowPlayingMoviesInteractor: GetNowPlayingMoviesUsecase {
    func execute(_ input: Void = ()) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        movieRepository.getNowPlayingMovies(request: GetMoviesNowPlayingRequestModel())
    }
}
