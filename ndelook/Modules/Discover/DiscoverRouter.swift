//
//  DiscoverRouter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

enum DiscoverDestination {}

protocol DiscoverWireframe: Wireframe where Destination == DiscoverDestination {}

class DiscoverRouter: DiscoverWireframe {
    let navigationSubject = PassthroughSubject<DiscoverDestination, Never>()
    internal weak var viewController: DiscoverViewController?
    
    init() {}
    
    static func createModule() -> DiscoverViewController {
        let router = DiscoverRouter()
        let presenter = DiscoverPresenter(
            router: router
        )
        let view = DiscoverViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}
