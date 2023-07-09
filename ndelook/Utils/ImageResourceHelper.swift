//
//  ImageResourceHelper.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

class ImageResourceHelper {
    enum ImageSourceConfigType: String {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
    }
    
    static func getRemoteImagePathFor(image: String) -> String {
        let sourceType: ImageSourceConfigType = .original
        return "/t/p/\(sourceType.rawValue)" + image
    }
}
