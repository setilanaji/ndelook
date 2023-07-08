//
//  Genre.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct GenresResponse: Codable, DomainModel {
    let genres: [GenreResponse]?
    
    func toDomain() -> GenresDomain {
        .init(genres: (genres ?? []).map { $0.toDomain() })
    }
}

struct GenreResponse: Codable, DomainModel {
    let id: Int?
    let name: String?
    
    func toDomain() -> GenreDomain {
        .init(id: id ?? 0, name: name ?? "")
    }
}
