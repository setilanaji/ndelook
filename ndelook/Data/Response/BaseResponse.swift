//
//  BaseResponse.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

// MARK: - Welcome
struct BaseResponse<T: Codable>: Codable {
    let page: Int?
    let results: T?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
