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
}

final class DiscoverPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<DiscoverViewEvent, Never>()
    private let getMoviesSubject = PassthroughSubject<GenreDomain, Never>()
    @Published private(set) var genre: String = ""
    @Published private(set) var movies = [MovieDiscoverDomain]()
    
    init<
        Router: DiscoverRouter,
        GetMoviesInteractor: GetMoviesUsecase
    >(
        router: Router,
        getMoviesInteractor: GetMoviesInteractor,
        genre: GenreDomain
    ) {
        self.genre = genre.name
        
        viewEventSubject
            .sink { event in
                switch event {
                case .viewDidLoad:
                    self.getMoviesSubject.send(genre)
                case .onTapMovie(let movieId):
                    router.navigationSubject.send(.toMovieDetail(movieId))
                }
            }.store(in: &cancelables)
        
        getMoviesSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[MovieDiscoverDomain]>, ErrorModel>, Never> in
                return getMoviesInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.movies = data.results
                }
            }
            .store(in: &cancelables)
    }
}
