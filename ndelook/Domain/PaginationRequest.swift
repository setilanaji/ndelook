//
//  PaginationRequest.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation

protocol PaginationRequestProtocol {
    var page: Int { get set }
    var isEnd: Bool { get set }
}

struct PaginationRequest: PaginationRequestProtocol {
    var page: Int
    var isEnd: Bool = false
    var params: [String: Any] = [:]
    var movieId: Int = 0
    
    mutating func nextPage() -> PaginationRequest {
        self.page += 1
        return self
    }
    
    mutating func onFailedRequest() {
        if self.page > 1 {
            self.page -= 1
        }
    }
}
