//
//  MovieRemoteDataSource.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol MovieRemoteDataSourceProtocol: AnyObject {
    func getMovieDetail(_ request: RequestModel) -> AnyPublisher<MovieDetailResponse, ErrorModel>
    
    func getMovieVideos(_ request: RequestModel) -> AnyPublisher<MovieVideosResponse, ErrorModel>
    
    func getReviews(_ request: RequestModel) -> AnyPublisher<BaseResponse<[ReviewResponse]>, ErrorModel>
    
    func getGenres(_ request: RequestModel) -> AnyPublisher<GenresResponse, ErrorModel>
    
    func getUpcomingMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel>
    
    func getPopularMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel>

    func getTopRatedMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel>

    func getNowPlayingMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel>

}

extension RemoteDataSource: MovieRemoteDataSourceProtocol {
    func getMovieDetail(_ request: RequestModel) -> AnyPublisher<MovieDetailResponse, ErrorModel> {
        guard let request = request as? GetMovieDetailRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        
        return self.manager.sendRequest(with: request)
    }
    
    func getMovieVideos(_ request: RequestModel) -> AnyPublisher<MovieVideosResponse, ErrorModel> {
        guard let request = request as? GetMovieVideosRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }
    
    func getReviews(_ request: RequestModel) -> AnyPublisher<BaseResponse<[ReviewResponse]>, ErrorModel> {
        guard let request = request as? GetMovieReviewsRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }
    
    func getGenres(_ request: RequestModel) -> AnyPublisher<GenresResponse, ErrorModel> {
        guard let request = request as? GetGenresRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }
    
    func getUpcomingMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel> {
        guard let request = request as? GetMoviesUpcomingRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }
    
    func getPopularMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel> {
        guard let request = request as? GetMoviesPopularRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }

    func getTopRatedMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel> {
        guard let request = request as? GetMoviesTopRatedRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }

    func getNowPlayingMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel> {
        guard let request = request as? GetMoviesNowPlayingRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        return self.manager.sendRequest(with: request)
    }
}
