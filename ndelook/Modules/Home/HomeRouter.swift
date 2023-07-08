//
//  HomeRouter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

enum HomeDestination {}

protocol HomeWireframe: Wireframe where Destination == HomeDestination {}

class HomeRouter: HomeWireframe {
    let navigationSubject = PassthroughSubject<HomeDestination, Never>()
    internal weak var viewController: HomeViewController?
    
    init() {}
    
    static func createModule() -> HomeViewController {
        let router = HomeRouter()
        let presenter = HomePresenter(
            router: router
        )
        let view = HomeViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}

