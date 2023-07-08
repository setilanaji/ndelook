//
//  PListHelper.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class NetworkConstant {
    static let shared = NetworkConstant()
    
    enum ConfigurationKey: String {
        case base = "Base"
        case pathDiscoverMovie = "PathDiscoverMovie"
        case pathGenresMovie = "PathGenresMovie"
    }
    
    private var configuration: [String: Any]?
    
    private init() {
        loadConfiguration()
    }
    
    private func loadConfiguration() {
        configuration = PlistHelper.load(.networkConstant)
    }
    
    func getValue<T>(forKey key: ConfigurationKey) -> T {
        guard let value = configuration?[key.rawValue] as? T else {
            fatalError("Value not found for key: \(key)")
        }
        return value
    }
}
