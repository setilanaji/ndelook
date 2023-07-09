//
//  Video.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct MovieVideosResponse: Codable, DomainModel {
    let id: Int?
    let results: [MovieVideoResponse]?
    
    func toDomain() -> MovieVideosDomain {
        return MovieVideosDomain(id: id ?? 0, results: (results ?? []).map { $0.toDomain() })
    }
}

struct MovieVideoResponse: Codable, DomainModel {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    
    func toDomain() -> MovieVideoDomain {
        return MovieVideoDomain(
            iso639_1: iso639_1 ?? "",
            iso3166_1: iso3166_1 ?? "",
            name: name ?? "",
            key: key ?? "",
            site: site ?? "",
            size: size ?? 0,
            type: type ?? "",
            official: official ?? false,
            publishedAt: publishedAt ?? "",
            id: id ?? ""
        )
    }
}
