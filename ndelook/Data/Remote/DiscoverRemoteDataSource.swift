//
//  DiscoverRemoteDataSource.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol DiscoverRemoteDataSourceProtocol: AnyObject {
    func getMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel>
}

extension RemoteDataSource: DiscoverRemoteDataSourceProtocol {
    func getMovies(_ request: RequestModel) -> AnyPublisher<BaseResponse<[MovieDiscoverResponse]>, ErrorModel> {
        guard let request = request as? GetDiscoverMoviesRequestModel else { return Fail(error: ErrorModel(message: "Wrong Request")).eraseToAnyPublisher() }
        
        return self.manager.sendRequest(with: request)
    }
}
