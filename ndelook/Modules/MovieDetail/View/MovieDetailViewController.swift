//
//  MovieDetailViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

class MovieDetailViewController: NiblessViewController {
    private let presenter: MovieDetailPresenter
    private var cancellables = Set<AnyCancellable>()
    
    init(presenter: MovieDetailPresenter) {
        self.presenter = presenter
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        presenter.viewEventSubject.send(.viewDidLoad)
    }
}
