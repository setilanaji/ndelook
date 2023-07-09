//
//  MovieDetailPresenter.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation
import Combine

enum MovieDetailViewEvent {
    case viewDidLoad
    case onTapReviews
    case onTapShare
    case onTapCheck
}

final class MovieDetailPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<MovieDetailViewEvent, Never>()
    private let getMovieDetailSubject = PassthroughSubject<Int, Never>()
    private let getMovieVideosSubject = PassthroughSubject<Int, Never>()
    private let getMovieReviewsSubject = PassthroughSubject<Int, Never>()

    @Published private(set) var movieDetail: MovieDetailDomain?
    @Published private(set) var movieTrailer: MovieVideoDomain?
    
    init<
        Router: MovieDetailRouter,
        GetMovieDetail: GetMovieDetailUsecase,
        GetMovieVideos: GetMovieVideosUsecase,
        GetMovieReviews: GetMovieReviewsUsecase
    >(
        router: Router,
        movieDetailInteractor: GetMovieDetail,
        movieVideosInteractor: GetMovieVideos,
        movieReviewsInteractor: GetMovieReviews,
        movieId: Int
    ) {
        viewEventSubject
            .sink { event in
                switch event {
                case .viewDidLoad:
                    DispatchQueue.global(qos: .userInteractive).async {
                        self.getMovieDetailSubject.send(movieId)
                        self.getMovieVideosSubject.send(movieId)
                    }
                case .onTapReviews:
                    router.navigationSubject.send(.toReviews(movieId))
                case .onTapShare:
                    router.navigationSubject.send(.toShare(movieId))
                case .onTapCheck:
                    router.navigationSubject.send(.toCheck(movieId))
                }
            }.store(in: &cancelables)
        
        getMovieDetailSubject
            .flatMap { value -> AnyPublisher<Result<MovieDetailDomain, ErrorModel>, Never> in
                return movieDetailInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.movieDetail = data
                }
            }
            .store(in: &cancelables)
        
        getMovieVideosSubject
            .flatMap { value -> AnyPublisher<Result<MovieVideosDomain, ErrorModel>, Never> in
                return movieVideosInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.movieTrailer = data.trailerVideo
                }
            }
            .store(in: &cancelables)
    }
}
