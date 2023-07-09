//
//  GetMovieVideosRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetMovieVideosRequestModel: RequestModel {
    private let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    override var path: String {
        NetworkConstant.shared.getValue(forKey: .pathMovie) + "/\(movieId)/videos"
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
