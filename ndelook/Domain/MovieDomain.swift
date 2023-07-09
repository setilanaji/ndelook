//
//  MovieDomain.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct MovieVideosDomain {
    let id: Int
    let results: [MovieVideoDomain]
    
    static let empty: MovieVideosDomain =
        .init(id: 0, results: [])
    
    var trailerVideo: MovieVideoDomain? {
        return self.results.first(where: { $0.site.lowercased() == "youtube" && $0.type.lowercased() == "trailer" })
    }
}

struct MovieVideoDomain {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String
}
