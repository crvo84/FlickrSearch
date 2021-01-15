//
//  SplashViewController.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

class SplashViewController: NiblessViewController {

    // MARK: - Properties
    private let viewModel: SplashViewModelProtocol
//    private let bag = DisposeBag()

    // MARK: - Initialization
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.didCompleteAnimation()
    }

    // MARK: - Setup

    private func setupUI() {
        view.applyTheme(bgColor: .mainTint)
    }
}
