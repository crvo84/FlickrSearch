//
//  MainDependencyContainer.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit

class MainDependencyContainer {

    // MARK: - Long-lived dependencies
    let userSessionRepository: UserSessionRepositoryProtocol
    let networkingManager: NetworkingManagerProtocol
    let mainViewModel: MainViewModelProtocol

    // MARK: - Initialization

    init() {
        self.userSessionRepository = DemoUserSessionRepository()
        self.networkingManager = NetworkingManager()
        self.mainViewModel = MainViewModel()
    }
}

// MARK: - Factories
extension MainDependencyContainer {

    func makeMainViewController() -> MainViewController {
        MainViewController(viewModel: mainViewModel,
                           splashViewController: makeSplashViewController(),
                           signedInViewControllerFactory: makeSignedInViewController)
    }

    // MARK: Splash
    func makeSplashViewController() -> SplashViewController {
        SplashViewController(viewModel: makeSplashViewModel())
    }

    func makeSplashViewModel() -> SplashViewModelProtocol {
        SplashViewModel(userSessionStateHandler: mainViewModel)
    }

    // MARK: Signed in
    func makeSignedInViewController() -> SignedInViewController {
        let dependencyContainer = SignedInDependencyContainer(mainDependencyContainer: self)
        return dependencyContainer.makeSignedInViewController()
    }
}
