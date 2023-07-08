//
//  HomeViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit
import Combine

class HomeViewController: NiblessViewController {
    private let presenter: HomePresenter
    private var cancellables = Set<AnyCancellable>()
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        presenter.viewEventSubject.send(.viewDidLoad)
    }
}
