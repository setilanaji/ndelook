//
//  Movie.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct MovieDiscoverResponse: Codable, DomainModel {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: OriginalLanguageResponse?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func toDomain() -> MovieDiscoverDomain {
        .init(
            adult: adult ?? false,
            backdropPath: backdropPath ?? "",
            genreIDS: genreIDS ?? [],
            id: id ?? 0,
            originalLanguage: (originalLanguage ?? .en).toDomain(),
            originalTitle: originalTitle ?? "",
            overview: overview ?? "",
            popularity: popularity ?? 0,
            posterPath: posterPath ?? "",
            releaseDate: releaseDate ?? "",
            title: title ?? "",
            video: video ?? false,
            voteAverage: voteAverage ?? 0,
            voteCount: voteCount ?? 0
        )
    }
}

enum OriginalLanguageResponse: String, Codable, DomainModel {
    case en = "en"
    case es = "es"
    case ja = "ja"
    
    func toDomain() -> OriginalLanguageDomain {
        .init(rawValue: self.rawValue) ?? .en
    }
}
