//
//  PlistHelper.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class PlistHelper {
    enum PlistType: String {
        case networkConstant = "NetworkConstant"
    }
    
    static func load(_ type: PlistType) -> [String: Any]? {
        guard let plistPath = Bundle.main.path(forResource: type.rawValue, ofType: "plist"),
              let plistData = FileManager.default.contents(atPath: plistPath),
              let loadedConfiguration = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any]
        else {
            return nil
        }
        
        return loadedConfiguration
    }
}
