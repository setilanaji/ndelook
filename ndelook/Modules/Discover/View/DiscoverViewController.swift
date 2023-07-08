//
//  DiscoverViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

class DiscoverViewController: NiblessViewController {
    private let presenter: DiscoverPresenter
    private var cancellables = Set<AnyCancellable>()
    
    init(presenter: DiscoverPresenter) {
        self.presenter = presenter
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        presenter.viewEventSubject.send(.viewDidLoad)
    }
}
