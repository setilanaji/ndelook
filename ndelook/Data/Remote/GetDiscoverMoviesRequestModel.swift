//
//  GetDiscoverMoviesRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetDiscoverMoviesRequestModel: RequestModel {
    
    override var path: String {
        return NetworkConstant.shared.getValue(forKey: .pathDiscoverMovie)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
