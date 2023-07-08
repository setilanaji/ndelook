//
//  MovieDetailRouter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

enum MovieDetailDestination {}

protocol MovieDetailWireframe: Wireframe where Destination == MovieDetailDestination {}

class MovieDetailRouter: MovieDetailWireframe {
    let navigationSubject = PassthroughSubject<MovieDetailDestination, Never>()
    internal weak var viewController: MovieDetailViewController?
    
    init() {}
    
    static func createModule() -> MovieDetailViewController {
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(
            router: router
        )
        let view = MovieDetailViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}
