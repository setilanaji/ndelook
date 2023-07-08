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
}

final class MovieDetailPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<MovieDetailViewEvent, Never>()
    
    init<
        Router: MovieDetailRouter
    >(
        router: Router
    ) {
        viewEventSubject
            .sink { event in
                switch event {
                case .viewDidLoad:
                    break
                }
            }.store(in: &cancelables)
    }
}
