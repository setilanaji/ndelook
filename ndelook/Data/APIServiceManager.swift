//
//  ServiceManager.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

class APIServiceManager: NSObject {
    static let shared: APIServiceManager = APIServiceManager()
    
    private func getVariableName(from error: Error) -> String {
        let errorString = "\(error)"
        let components = errorString.components(separatedBy: ".").filter { $0.contains("CodingKeys") }
        let variableName = components.last?.replacingOccurrences(of: "CodingKeys(", with: "").replacingOccurrences(of: ")", with: "")
        return variableName ?? "Unknown Variable"
    }
    
    func sendRequest<T: Codable>(with request: RequestModel) -> AnyPublisher<T, ErrorModel> {
        
        return URLSession.shared.dataTaskPublisher(for: request.urlRequest())
            .tryMap { output in
                if let httpResponse = output.response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        return output.data
                    case 400...599:
                        if let parsedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: output.data) {
                            if let message = parsedResponse.statusMessage {
                                throw ErrorModel(message: "\(message)", statusCode: httpResponse.statusCode)
                            } else {
                                throw ErrorModel(message: "\(parsedResponse)", statusCode: httpResponse.statusCode)
                            }
                        }
                        
                        throw ErrorModel(message: "FAIL", statusCode: httpResponse.statusCode)
                    default:
                        throw ErrorModel(message: "Unknown Error")
                    }
                } else {
                    return output.data
                }
            }
            .tryMap { data in
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode(T.self, from: data)
                } catch let decodingError {
                    let variableName = self.getVariableName(from: decodingError)
                    let errorMessage = "Decoding Error for variable '\(variableName)': \(decodingError.localizedDescription)"
                    throw ErrorModel(message: errorMessage)
                }
            }
            .mapError { error in
                if let customError = error as? ErrorModel {
                    return customError
                } else {
                    return ErrorModel(message: "Unknown Error: \(error.localizedDescription)")
                }
            }
            .eraseToAnyPublisher()
        
    }
}
