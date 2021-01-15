//
//  MainViewModel.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import RxSwift

protocol MainViewModelProtocol: UserSessionStateHandler {
    var viewType: Observable<MainViewType> { get }
}

class MainViewModel: MainViewModelProtocol {
    private let viewTypeSubject = PublishSubject<MainViewType>()
    var viewType: Observable<MainViewType> { viewTypeSubject }
}

// MARK: - UserSessionStateHandler
extension MainViewModel {

    func handleUserSessionState(_ state: UserSessionState) {
        switch state {
        case .signedIn(let session):
            viewTypeSubject.onNext(.signedIn(userSession: session))
        case .notSignedIn:
            // send onboarding viewType event
            break
        }
    }
}

