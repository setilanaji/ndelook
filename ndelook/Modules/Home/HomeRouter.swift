//
//  HomeRouter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

enum HomeDestination {
    case toMovieDetail(Int)
    case toDiscovery(GenreDomain)
}

protocol HomeWireframe: Wireframe where Destination == HomeDestination {}

class HomeRouter: HomeWireframe {
    private var cancellables = Set<AnyCancellable>()
    let navigationSubject = PassthroughSubject<HomeDestination, Never>()
    internal weak var viewController: HomeViewController?
    
    init() {
        navigationSubject
            .sink { destination in
                switch destination {
                case .toMovieDetail(let movieId):
                    let view = MovieDetailRouter.createModule(movieId: movieId)
                    view.modalPresentationStyle = .overFullScreen
                    self.viewController?.navigationController?.present(view, animated: true)
                case .toDiscovery(let genre):
                    let view = DiscoverRouter.createModule(genre: genre)
                    self.viewController?.navigationController?.pushViewController(view, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    static func createModule() -> HomeViewController {
        let router = HomeRouter()
        let movieRepository = RepositoryInjection.provideMovieRepository()
        let getGenresInteractor = GetGenresInteractor(movieRepository: movieRepository)
        let getUpcomingMoviesInteractor = GetUpcomingMoviesInteractor(movieRepository: movieRepository)
        let getTopRatedMoviesInteractor = GetTopRatedMoviesInteractor(movieRepository: movieRepository)
        let getPopularMoviesInteractor = GetPopularMoviesInteractor(movieRepository: movieRepository)
        let getNowPlayingMoviesInteractor = GetNowPlayingMoviesInteractor(movieRepository: movieRepository)
        
        let presenter = HomePresenter(
            router: router,
            getGenresInteractor: getGenresInteractor,
            getUpcomingMoviesInteractor: getUpcomingMoviesInteractor,
            getTopRatedMoviesInteractor: getTopRatedMoviesInteractor,
            getPopularMoviesInteractor: getPopularMoviesInteractor,
            getNowPlayingMoviesInteractor: getNowPlayingMoviesInteractor
        )
        let view = HomeViewController(presenter: presenter)
        router.viewController = view
        
        return view
    }
}

