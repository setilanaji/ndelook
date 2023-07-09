//
//  GetDiscoverMoviesRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetDiscoverMoviesRequestModel: RequestModel {
    private let genre: Int
    
    init(genre: Int) {
        self.genre = genre
    }
    
    override var path: String {
        return NetworkConstant.shared.getValue(forKey: .pathDiscoverMovie)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
    
    override var parameters: [String : Any?] {
        return ["with_genres": genre]
    }
}
