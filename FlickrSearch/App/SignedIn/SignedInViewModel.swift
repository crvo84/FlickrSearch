//
//  SignedInViewModel.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import RxSwift

protocol GoToPicturesGridNavigator {
    func navigateToPicturesGrid(for search: Search)
}

protocol SignedInViewModelProtocol: GoToPicturesGridNavigator {
    var viewType: Observable<SignedInViewType> { get }
}

class SignedInViewModel: SignedInViewModelProtocol {
    private let viewTypeSubject = BehaviorSubject<SignedInViewType>(value: .searchPictures)
    var viewType: Observable<SignedInViewType> { viewTypeSubject }

    func navigateToPicturesGrid(for search: Search) {
        viewTypeSubject.onNext(.picturesGrid(search))
    }
}
