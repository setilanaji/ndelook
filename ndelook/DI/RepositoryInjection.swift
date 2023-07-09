//
//  RepositoryInjection.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

final class RepositoryInjection: NSObject {
    static func provideMovieRepository() -> MovieRepositoryProtocol {
        return MovieRepository.shared(RemoteDataSource.shared(APIServiceManager.shared))
    }
    
    static func provideDiscoveryRepository() -> DiscoverRepositoryProtocol {
        return DiscoverRepository.shared(RemoteDataSource.shared(APIServiceManager.shared))
    }
}
