//
//  GetMoviesPopularRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetMoviesPopularRequestModel: RequestModel {
    override var path: String {
        NetworkConstant.shared.getValue(forKey: .pathMoviePopular)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
