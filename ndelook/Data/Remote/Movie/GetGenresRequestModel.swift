//
//  GetGenresRequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class GetGenresRequestModel: RequestModel {
    override var path: String {
        return NetworkConstant.shared.getValue(forKey: .pathGenresMovie)
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
}
