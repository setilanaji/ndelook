//
//  DomainModel.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

protocol DomainModel {
    associatedtype DomainModelType
    
    func toDomain() -> DomainModelType
}
