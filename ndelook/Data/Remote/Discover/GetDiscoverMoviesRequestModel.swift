//
//  GetDiscoverMoviesRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetDiscoverMoviesRequestModel: RequestModel {
    private let page: Int
    private let params: [String: Any]
    
    init(
        params: [String: Any],
        page: Int
    ) {
        self.params = params
        self.page = page
    }
    
    override var path: String {
        return NetworkConstant.shared.getValue(forKey: .pathDiscoverMovie)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
    
    override var parameters: [String : Any?] {
        var params: [String: Any] = [
            "page": page
        ]
        params.merge(self.params, uniquingKeysWith: { (_, new) in new })
        return params
    }
}
