//
//  DiscoverPresenter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

enum DiscoverViewEvent {
    case viewDidLoad
    case onTapMovie(Int)
    case loadMore
}

final class DiscoverPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<DiscoverViewEvent, Never>()
    private let getMoviesSubject = PassthroughSubject<PaginationRequestProtocol, Never>()
    
    @Published private(set) var genre: String = ""
    @Published private(set) var movies = [MovieDiscoverDomain]()
    @Published private(set) var isLoading: Bool = false

    private var params: [String: Any] = [:]
    private lazy var moviesPagination: PaginationRequest = {
        return PaginationRequest(page: 1, params: self.params)
    }()
    
    init<
        Router: DiscoverRouter,
        GetMoviesInteractor: GetMoviesUsecase
    >(
        router: Router,
        getMoviesInteractor: GetMoviesInteractor,
        genre: GenreDomain
    ) {
        self.genre = genre.name
        self.params = ["with_genres": genre.id]
        viewEventSubject
            .sink { event in
                switch event {
                case .viewDidLoad:
                    self.moviesPagination = .init(page: 1, params: self.params)
                    self.getMoviesSubject.send(self.moviesPagination)
                case .onTapMovie(let movieId):
                    router.navigationSubject.send(.toMovieDetail(movieId))
                case .loadMore:
                    if !self.isLoading, !self.moviesPagination.isEnd {
                        self.getMoviesSubject.send(self.moviesPagination.nextPage())
                    }
                }
            }.store(in: &cancelables)
        
        getMoviesSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>, Never> in
                self.isLoading = true
                return getMoviesInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    print(error.message)
                    self?.moviesPagination.onFailedRequest()
                case .success(let data):
                    var prevMovies = (self?.movies ?? [])
                    prevMovies.append(contentsOf: data.results)
                    let currentCount = prevMovies.count
                    self?.moviesPagination.isEnd = data.totalResults <= currentCount
                    self?.movies = prevMovies
                }
            }
            .store(in: &cancelables)
    }
}
