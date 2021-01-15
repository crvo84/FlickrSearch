//
//  SplashViewModel.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

protocol SplashViewModelProtocol {
    func didCompleteAnimation()
}

class SplashViewModel: SplashViewModelProtocol {

    // MARK: - Properties
    private let userSessionStateHandler: UserSessionStateHandler

    init(userSessionStateHandler: UserSessionStateHandler) {
        self.userSessionStateHandler = userSessionStateHandler
    }

    func didCompleteAnimation() {
        userSessionStateHandler.handleUserSessionState(.signedIn(userSession: .demo))
    }
}
