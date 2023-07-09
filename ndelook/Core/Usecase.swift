//
//  Usecase.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol Usecase {
    associatedtype Input
    associatedtype Output
    associatedtype Failure: Error
    
    func execute(_ input: Input) -> AnyPublisher<Output, Failure>
}
