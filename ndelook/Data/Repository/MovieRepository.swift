//
//  MovieRepository.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol: AnyObject {
    func getMovieDetail(request: RequestModel) -> AnyPublisher<MovieDetailDomain, ErrorModel>
    
    func getMovieVideos(request: RequestModel) -> AnyPublisher<MovieVideosDomain, ErrorModel>
    
    func getMovieReviews(request: RequestModel) -> AnyPublisher<BaseDomain<[ReviewDomain]>, ErrorModel>
    
    func getGenres(request: RequestModel) -> AnyPublisher<GenresDomain, ErrorModel>
    
    func getUpcomingMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>
    
    func getPopularMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>

    func getTopRatedMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>

    func getNowPlayingMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>

}

final class MovieRepository: NSObject {
    typealias MovieRepositoryInstance = (RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(
        remote: RemoteDataSource
    ) {
        self.remote = remote
    }
    
    static let shared: MovieRepositoryInstance = { remote in
        return MovieRepository(remote: remote)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func getMovieDetail(request: RequestModel) -> AnyPublisher<MovieDetailDomain, ErrorModel> {
        remote
            .getMovieDetail(request)
            .map { response in
                response.toDomain()
            }
            .eraseToAnyPublisher()
    }
    
    func getMovieVideos(request: RequestModel) -> AnyPublisher<MovieVideosDomain, ErrorModel> {
        remote
            .getMovieVideos(request)
            .map { response in
                response.toDomain()
            }
            .eraseToAnyPublisher()
    }
    
    func getMovieReviews(request: RequestModel) -> AnyPublisher<BaseDomain<[ReviewDomain]>, ErrorModel> {
        remote
            .getReviews(request)
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
    
    func getGenres(request: RequestModel) -> AnyPublisher<GenresDomain, ErrorModel> {
        remote
            .getGenres(request)
            .map { response in
                response.toDomain()
            }
            .eraseToAnyPublisher()
    }
    
    func getUpcomingMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        remote
            .getUpcomingMovies(request)
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
    
    func getPopularMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        remote
            .getPopularMovies(request)
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

    func getTopRatedMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        remote
            .getTopRatedMovies(request)
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

    func getNowPlayingMovies(request: RequestModel) -> AnyPublisher<BaseDomain<[MovieDiscoverDomain]>, ErrorModel> {
        remote
            .getNowPlayingMovies(request)
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
