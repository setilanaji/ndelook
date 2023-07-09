//
//  DiscoverRouter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

enum DiscoverDestination {
    case toMovieDetail(Int)
}

protocol DiscoverWireframe: Wireframe where Destination == DiscoverDestination {}

class DiscoverRouter: DiscoverWireframe {
    let navigationSubject = PassthroughSubject<DiscoverDestination, Never>()
    internal weak var viewController: DiscoverViewController?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        navigationSubject
            .sink { destination in
                switch destination {
                case .toMovieDetail(let movieId):
                    let view = MovieDetailRouter.createModule(movieId: movieId)
                    view.modalPresentationStyle = .overFullScreen
                    self.viewController?.navigationController?.present(view, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    static func createModule(
        genre: GenreDomain
    ) -> DiscoverViewController {
        let router = DiscoverRouter()
        let getMoviesInteractor = GetMoviesInteractor(discoverRepository: RepositoryInjection.provideDiscoveryRepository())
        
        let presenter = DiscoverPresenter(
            router: router,
            getMoviesInteractor: getMoviesInteractor,
            genre: genre
        )
        let view = DiscoverViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}
