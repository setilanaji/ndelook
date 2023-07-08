//
//  DiscoverMovieDomain.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct MovieDiscoverDomain {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguageDomain
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    static let empty: MovieDiscoverDomain =
        .init(
            adult: false,
            backdropPath: "",
            genreIDS: [],
            id: 0,
            originalLanguage: .en,
            originalTitle: "",
            overview: "",
            popularity: 0,
            posterPath: "",
            releaseDate: "",
            title: "",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )
}

enum OriginalLanguageDomain: String {
    case en = "en"
    case es = "es"
    case ja = "ja"
}
