//
//  SearchPicturesViewModel.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import RxSwift

protocol SearchPicturesViewModelProtocol {
    var searches: [Search] { get }
    var searchTextSubject: PublishSubject<String?> { get }
    var updateUIObservable: Observable<Void> { get }
    func showPicturesGrid(for search: Search)
}

class SearchPicturesViewModel: SearchPicturesViewModelProtocol {

    private let picturesRepository: PicturesRepositoryProtocol
    private let goToPicturesGridNavigator: GoToPicturesGridNavigator
    private let searchesSubject = BehaviorSubject<[Search]>(value: [])
    private let bag = DisposeBag()

    let searchTextSubject = PublishSubject<String?>()

    var updateUIObservable: Observable<Void> {
        searchesSubject.map { _ in }
    }

    var searches: [Search] {
        (try? searchesSubject.value()) ?? []
    }

    init(picturesRepository: PicturesRepositoryProtocol,
         goToPicturesGridNavigator: GoToPicturesGridNavigator) {
        self.picturesRepository = picturesRepository
        self.goToPicturesGridNavigator = goToPicturesGridNavigator
        bind()
    }

    func showPicturesGrid(for search: Search) {
        guard search.totalResults > 0 else { return }
        
        goToPicturesGridNavigator.navigateToPicturesGrid(for: search)
    }

    private func bind() {
        searchTextSubject.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                if let text = $0, !text.isEmpty {
                    self?.searchPictures(text: text)
                } else {
                    self?.searchesSubject.onNext(self?.searches ?? [])
                }
            }).disposed(by: bag)
    }

    private func searchPictures(text: String) {
        picturesRepository.searchPictures(text: text, limit: 1, page: 1)
            .subscribe(onSuccess: { [weak self] searchResult in
                let newSearch = Search(text: text, totalResults: searchResult.totalPhotos)
                let prevSearches = self?.searches ?? []
                self?.searchesSubject.onNext(prevSearches + [newSearch])
            }).disposed(by: bag)
    }
}
