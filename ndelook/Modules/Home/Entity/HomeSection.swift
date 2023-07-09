//
//  HomeSection.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

enum HomeSection: Int, CaseIterable {
    case genres
    case nowPlaying
    case topRated
    case upcoming
    case popular
    
    var sectionTitle: String {
        switch self {
        case .genres:
            return ""
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        }
    }
}
