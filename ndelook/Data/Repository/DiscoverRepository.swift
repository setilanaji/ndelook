//
//  DiscoverRepository.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol DiscoverRepositoryProtocol: AnyObject {
    func getMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>
}

final class DiscoverRepository: NSObject {
    typealias DiscoverRepositoryInstance = (RemoteDataSource) -> DiscoverRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(
        remote: RemoteDataSource
    ) {
        self.remote = remote
    }
    
    static let shared: DiscoverRepositoryInstance = { remote in
        return DiscoverRepository(remote: remote)
    }
}

extension DiscoverRepository: DiscoverRepositoryProtocol {
    func getMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        remote
            .getMovies(request)
            .map { response in
                BaseDomain(
                    page: response.page ?? 0,
                    results: (response.results ?? []).map { $0.toDomain() },
                    totalPages: response.totalPages ?? 0,
                    totalResults: response.totalResults ?? 0
                )
            }
            .eraseToAnyPublisher()
    }
}
