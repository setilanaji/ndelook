//
//  Review.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct ReviewResponse: Codable, DomainModel {
    let author: String?
    let authorDetails: AuthorDetailsResponse?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
    
    func toDomain() -> ReviewDomain {
        ReviewDomain(
            author: author ?? "",
            authorDetails: authorDetails?.toDomain() ?? .empty,
            content: content ?? "",
            createdAt: createdAt ?? "",
            id: id ?? "",
            updatedAt: updatedAt ?? "",
            url: url ?? ""
        )
    }
}

// MARK: - AuthorDetails
struct AuthorDetailsResponse: Codable, DomainModel {
    let name, username, avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
    
    func toDomain() -> AuthorDetailsDomain {
        AuthorDetailsDomain(name: name ?? "", username: username ?? "", avatarPath: avatarPath ?? "", rating: rating ?? 0)
    }
}
