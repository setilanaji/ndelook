//
//  GenreDomain.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct GenresDomain {
    let genres: [GenreDomain]
    
    static let empty: GenresDomain =
        .init(genres: [])
}

struct GenreDomain {
    let id: Int
    let name: String
    
    static let empty: GenreDomain =
        .init(id: 0, name: "")
}
