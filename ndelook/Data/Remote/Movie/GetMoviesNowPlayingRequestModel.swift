//
//  GetMoviesNowPlayingRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetMoviesNowPlayingRequestModel: RequestModel {
    override var path: String {
        NetworkConstant.shared.getValue(forKey: .pathMovieNowPlaying)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
