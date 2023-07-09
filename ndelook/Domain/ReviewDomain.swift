//
//  ReviewDomain.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct ReviewDomain {
    let author: String
    let authorDetails: AuthorDetailsDomain
    let content, createdAt, id, updatedAt: String
    let url: String
    
    var postDate: String {
        return createdAt.formatReviewDate()
    }
    
    static let empty = ReviewDomain(
        author: "",
        authorDetails: .empty,
        content: "",
        createdAt: "",
        id: "",
        updatedAt: "",
        url: ""
    )
}

// MARK: - AuthorDetails
struct AuthorDetailsDomain {
    let name, username, avatarPath: String
    let rating: Int
    
    static let empty = AuthorDetailsDomain(name: "", username: "", avatarPath: "", rating: 0)
}
