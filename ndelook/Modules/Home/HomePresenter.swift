//
//  HomePresenter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

enum HomeViewEvent {
    case viewDidLoad
    case onTapMovie(Int)
    case onTapGenre(GenreDomain)
}

final class HomePresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<HomeViewEvent, Never>()
    private let getGenresSubject = PassthroughSubject<Void, Never>()
    private let getPopularMoviesSubject = PassthroughSubject<Void, Never>()
    private let getNowPlayingMoviesSubject = PassthroughSubject<Void, Never>()
    private let getUpcomingMoviesSubject = PassthroughSubject<Void, Never>()
    private let getTopRatedMoviesSubject = PassthroughSubject<Void, Never>()

    @Published private(set) var sectionData: [HomeSection: Any] = [
        .genres: [GenreDomain](),
        .topRated: [MovieDiscoverDomain](),
        .upcoming: [MovieDiscoverDomain](),
        .nowPlaying: [MovieDiscoverDomain](),
        .popular: [MovieDiscoverDomain]()
    ]
    
    init<
        Router: HomeRouter,
        GetGenresInteractor: GetGenresUsecase,
        GetUpcomingMoviesInteractor: GetUpcomingMoviesUsecase,
        GetTopRatedMoviesInteractor: GetTopRatedMoviesUsecase,
        GetPopularMoviesInteractor: GetPopularMoviesUsecase,
        GetNowPlayingMoviesInteractor: GetNowPlayingMoviesUsecase
    >(
        router: Router,
        getGenresInteractor: GetGenresInteractor,
        getUpcomingMoviesInteractor: GetUpcomingMoviesInteractor,
        getTopRatedMoviesInteractor: GetTopRatedMoviesInteractor,
        getPopularMoviesInteractor: GetPopularMoviesInteractor,
        getNowPlayingMoviesInteractor: GetNowPlayingMoviesInteractor
    ) {
        viewEventSubject
            .sink { event in
                switch event {
                case .viewDidLoad:
                    DispatchQueue.main.async {
                        self.getGenresSubject.send(())
                        self.getPopularMoviesSubject.send(())
                        self.getUpcomingMoviesSubject.send(())
                        self.getTopRatedMoviesSubject.send(())
                        self.getNowPlayingMoviesSubject.send(())
                    }
                case .onTapMovie(let movieId):
                    router.navigationSubject.send(.toMovieDetail(movieId))
                case .onTapGenre(let genre):
                    router.navigationSubject.send(.toDiscovery(genre))
                }
            }.store(in: &cancelables)
        
        getGenresSubject
            .flatMap { value -> AnyPublisher<Result<GenresDomain, ErrorModel>, Never> in
                return getGenresInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.sectionData[.genres] = data.genres
                }
            }
            .store(in: &cancelables)
        
        getUpcomingMoviesSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>, Never> in
                return getUpcomingMoviesInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.sectionData[.upcoming] = data.results
                }
            }
            .store(in: &cancelables)
        
        getTopRatedMoviesSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>, Never> in
                return getTopRatedMoviesInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.sectionData[.topRated] = data.results
                }
            }
            .store(in: &cancelables)
        
        getNowPlayingMoviesSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>, Never> in
                return getNowPlayingMoviesInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.sectionData[.nowPlaying] = data.results
                }
            }
            .store(in: &cancelables)
        
        getPopularMoviesSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>, Never> in
                return getPopularMoviesInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.sectionData[.popular] = data.results
                }
            }
            .store(in: &cancelables)
    }
}
