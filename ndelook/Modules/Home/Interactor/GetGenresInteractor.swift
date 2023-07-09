//
//  GetGenresInteractor.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol GetGenresUsecase: Usecase
where Input == Void,
      Output == GenresDomain,
      Failure == ErrorModel {}


final class GetGenresInteractor {
    fileprivate let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
}

extension GetGenresInteractor: GetGenresUsecase {
    func execute(_ input: Void = ()) -> AnyPublisher<GenresDomain, ErrorModel> {
        movieRepository.getGenres(request: GetGenresRequestModel())
    }
}
