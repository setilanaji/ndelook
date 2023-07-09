//
//  GetMoviesTopRatedRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetMoviesTopRatedRequestModel: RequestModel {
    override var path: String {
        NetworkConstant.shared.getValue(forKey: .pathMovieTopRated)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
