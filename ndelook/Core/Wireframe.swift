//
//  Wireframe.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol Wireframe: AnyObject {
    associatedtype Destination
    
    var navigationSubject: PassthroughSubject<Destination, Never> { get }
}
