//
//  SignedInDependencyContainer.swift
//  TheamMusic
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import Foundation

class SignedInDependencyContainer {

    // MARK: - Long-lived dependencies
    private let mainViewModel: MainViewModelProtocol
    private let signedInViewModel: SignedInViewModelProtocol
    private let networkingManager: NetworkingManagerProtocol
    private let picturesRepository: PicturesRepositoryProtocol
    private let userSessionRepository: UserSessionRepositoryProtocol

    init(mainDependencyContainer container: MainDependencyContainer) {
        self.userSessionRepository = container.userSessionRepository
        self.networkingManager = container.networkingManager
        self.mainViewModel = container.mainViewModel
        self.signedInViewModel = SignedInViewModel()
        let networkingManager = container.networkingManager
        self.picturesRepository = SignedInDependencyContainer.makePicturesRepository(networkingManager: networkingManager)
    }

    private static func makePicturesRepository(networkingManager: NetworkingManagerProtocol) -> PicturesRepositoryProtocol {
        let remoteService = FlickrPicturesRemoteService(networkingManager: networkingManager)
        return FlickrPicturesRepository(remoteService: remoteService)
    }
}

// MARK: - Factories
extension SignedInDependencyContainer {

    func makeSignedInViewController() -> SignedInViewController {
        SignedInViewController(viewModel: signedInViewModel,
                               searchPicturesViewControllerFactory: makeSearchPicturesViewController,
                               picturesGridViewControllerFactory: makePicturesGridViewController)
    }

    // MARK: Albums
    private func makeSearchPicturesViewController() -> SearchPicturesViewController {
        let viewModel = makeSearchPicturesViewModel()
        return SearchPicturesViewController(viewModel: viewModel)
    }

    private func makeSearchPicturesViewModel() -> SearchPicturesViewModelProtocol {
        SearchPicturesViewModel(picturesRepository: picturesRepository, goToPicturesGridNavigator: signedInViewModel)
    }

    // MARK: Songs
    private func makePicturesGridViewController(search: Search) -> PicturesGridViewController {
        let viewModel = makePicturesGridViewModel(search: search)
        return PicturesGridViewController(viewModel: viewModel)
    }

    private func makePicturesGridViewModel(search: Search) -> PicturesGridViewModelProtocol {
        PicturesGridViewModel(search: search, picturesRepository: picturesRepository)
    }
}
