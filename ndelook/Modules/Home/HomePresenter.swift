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
}

final class HomePresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<HomeViewEvent, Never>()
    
    init<
        Router: HomeRouter
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
