//
//  ReviewsPresenter.swift
//  ndelook
//
//  Created by Yudha S on 09/07/23.
//

import Foundation
import Combine

enum ReviewsViewEvent {
    case viewDidLoad
}

final class ReviewsPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<ReviewsViewEvent, Never>()
    private let getMovieReviewsSubject = PassthroughSubject<Int, Never>()
    
    @Published private(set) var reviews = [ReviewDomain]()
    
    init<
        Router: ReviewsWireframe,
        GetMovieReviews: GetMovieReviewsUsecase
    >(
        router: Router,
        movieReviewsInteractor: GetMovieReviews,
        movieId: Int
    ) {
        viewEventSubject
            .sink { event in
                switch event {
                case .viewDidLoad:
                    self.getMovieReviewsSubject.send(movieId)
                }
            }.store(in: &cancelables)
        
        getMovieReviewsSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[ReviewDomain]>, ErrorModel>, Never> in
                return movieReviewsInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error.message)
                case .success(let data):
                    self?.reviews = data.results
                }
            }
            .store(in: &cancelables)
    }
}
