//
//  GetMoviesInteractor.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

protocol GetMoviesUsecase: Usecase
where Input == PaginationRequestProtocol,
      Output == BaseDomain<[MovieDiscoverDomain]>,
      Failure == ErrorModel {}


final class GetMoviesInteractor {
    fileprivate let discoverRepository: DiscoverRepositoryProtocol
    
    init(discoverRepository: DiscoverRepositoryProtocol) {
        self.discoverRepository = discoverRepository
    }
}

extension GetMoviesInteractor: GetMoviesUsecase {
    func execute(_ input: PaginationRequestProtocol) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        guard let request = input as? PaginationRequest else {
            return Fail(error: ErrorModel(message: "Wrong request")).eraseToAnyPublisher()
        }
        return discoverRepository.getMovies(request: GetDiscoverMoviesRequestModel(params: request.params, page: request.page))
    }
}
