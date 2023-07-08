//
//  Presentation.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

protocol Presentation: ObservableObject {
    associatedtype ViewEvent
    
    var viewEventSubject: PassthroughSubject<ViewEvent, Never> { get }
}
