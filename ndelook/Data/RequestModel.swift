//
//  RequestModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

enum HTTPRequestMethod: String {
    case get = "GET"
}

enum ContentType: String {
    case applicationJson = "application/json"
}

class RequestModel: NSObject {
    var base: String { return NetworkConstant.shared.getValue(forKey: .base) }
    var path: String { return "" }
    var parameters: [String: Any?] { return [:] }
    var headers: [String: String] { return [:] }
    var method: HTTPRequestMethod { return .get }
}

extension RequestModel {
    func urlRequest() -> URLRequest {
        var endpoint: String = base.appending(path)
        
        for (index, parameter) in parameters.enumerated() {
            if let value = parameter.value as? String {
                endpoint.append("\(index == 0 ? "?" : "&")\(parameter.key)=\(value)")
            }
            if let value = parameter.value as? Int {
                endpoint.append("\(index == 0 ? "?" : "&")\(parameter.key)=\(value)")
            }
            if let value = parameter.value as? Bool {
                endpoint.append("\(index == 0 ? "?" : "&")\(parameter.key)=\(value)")
            }
            if let value = parameter.value as? [Int] {
                endpoint.append("\(index == 0 ? "?" : "&")\(parameter.key)=\(value.map { "\($0)" }.joined(separator: ","))")
            }
        }
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!)
        request.httpMethod = method.rawValue
        let userToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZDYyZGRkYmE1MDMyNDA1MzkyODhkYzg4NmRhZWQ3OCIsInN1YiI6IjVmYzM3MGYxMTc0YTg3MDA0MmUyYTMyNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tCQAG8orP-YrGP1wsfjA_kWwuk2WR-5Oc5ya6zYEyII"
        
        let newHeaders = headers.merging([
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ], uniquingKeysWith: { (_, new) in new })
        
        request.allHTTPHeaderFields = newHeaders

        return request
    }
}
