//
//  ErrorModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct ErrorResponse: Codable {
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

class ErrorModel: Error {
    var message: String = ""
    var statusCode: Int?
    
    init(
        message: String,
        statusCode: Int? = nil
    ) {
        self.statusCode = statusCode
        self.message = message
    }
}
