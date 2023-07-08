//
//  NiblessViewController.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import UIKit

open class NiblessViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }
    
    @available(*, unavailable, message: "Unsupported")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Unsupported")
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

