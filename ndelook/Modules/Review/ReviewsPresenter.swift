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
    case loadMore
}

final class ReviewsPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<ReviewsViewEvent, Never>()
    private let getMovieReviewsSubject = PassthroughSubject<PaginationRequestProtocol, Never>()
    
    @Published private(set) var reviews: [ReviewDomain] = []
    @Published private(set) var isLoading: Bool = false
    private var params: [String: Any] = [:]
    
    private lazy var reviewPagination: PaginationRequest = {
        return PaginationRequest(page: 1, params: self.params, movieId: 0)
    }()
    
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
                    self.reviewPagination = .init(page: 1, movieId: movieId)
                    self.getMovieReviewsSubject.send(self.reviewPagination)
                case .loadMore:
                    if !self.isLoading, !self.reviewPagination.isEnd {
                        self.getMovieReviewsSubject.send(self.reviewPagination.nextPage())
                    }
                }
            }.store(in: &cancelables)
        
        getMovieReviewsSubject
            .flatMap { value -> AnyPublisher<Result<BaseDomain<[ReviewDomain]>, ErrorModel>, Never> in
                self.isLoading = true
                return movieReviewsInteractor.execute(value)
                    .convertToResultPublisher()
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    print(error.message)
                    self?.reviewPagination.onFailedRequest()
                case .success(let data):
                    var prevReviews = (self?.reviews ?? [])
                    prevReviews.append(contentsOf: data.results)
                    let currentCount = prevReviews.count
                    self?.reviewPagination.isEnd = data.totalResults <= currentCount
                    self?.reviews = prevReviews
                }
            }
            .store(in: &cancelables)
    }
}
