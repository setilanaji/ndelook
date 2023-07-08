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
}

final class DiscoverPresenter: Presentation {
    private var cancelables: Set<AnyCancellable> = []
    var viewEventSubject = PassthroughSubject<DiscoverViewEvent, Never>()
    
    init<
        Router: DiscoverRouter
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
