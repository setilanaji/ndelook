//
//  GetMoviesInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetMoviesUsecase: Usecase
where Input == GenreDomain,
      Output == BaseDomain<[MovieDiscoverDomain]>,
      Failure == ErrorModel {}


final class GetMoviesInteractor {
    fileprivate let discoverRepository: DiscoverRepositoryProtocol
    
    init(discoverRepository: DiscoverRepositoryProtocol) {
        self.discoverRepository = discoverRepository
    }
}

extension GetMoviesInteractor: GetMoviesUsecase {
    func execute(_ input: GenreDomain) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        return discoverRepository.getMovies(request: GetDiscoverMoviesRequestModel(genre: input.id))
    }
}
