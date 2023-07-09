//
//  GetMoviesUpcomingRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetMoviesUpcomingRequestModel: RequestModel {
    override var path: String {
        NetworkConstant.shared.getValue(forKey: .pathMovieUpcoming)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
