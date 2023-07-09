//
//  GetMovieVideosInteractor.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol GetMovieVideosUsecase: Usecase
where Input == Int,
      Output == MovieVideosDomain,
      Failure == ErrorModel {}


final class GetMovieVideosInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetMovieVideosInteractor: GetMovieVideosUsecase {
    func execute(_ input: Int) -> AnyPublisher<MovieVideosDomain, ErrorModel> {
        movieRepository.getMovieVideos(request: GetMovieVideosRequestModel(movieId: input))
    }
}
