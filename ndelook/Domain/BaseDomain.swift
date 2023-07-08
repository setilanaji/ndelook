//
//  BaseDomain.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

struct BaseDomain<T> {
    let page: Int
    let results: T
    let totalPages, totalResults: Int
}
