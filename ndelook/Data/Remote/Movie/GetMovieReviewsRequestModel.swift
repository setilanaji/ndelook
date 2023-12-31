//
//  GetMovieReviewsRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetMovieReviewsRequestModel: RequestModel {
    private let movieId: Int
    private let page: Int
    
    init(
        movieId: Int,
        page: Int
    ) {
        self.movieId = movieId
        self.page = page
    }
    
    override var path: String {
        NetworkConstant.shared.getValue(forKey: .pathMovie) + "/\(movieId)/reviews"
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
    
    override var parameters: [String : Any?] {
        return [
            "page": page
        ]
    }
}
