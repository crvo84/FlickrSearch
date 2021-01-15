//
//  PicturesGridViewModel.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import RxSwift

protocol PicturesGridViewModelProtocol {
    var title: String? { get }
    var pictures: [Picture] { get }
    var updateUIObservable: Observable<Void> { get }
    func loadNextPage()
}

class PicturesGridViewModel: PicturesGridViewModelProtocol {

    enum Config {
        static let limit = 30
    }

    private let search: Search
    private let picturesRepository: PicturesRepositoryProtocol
    private let picturesSubject = BehaviorSubject<[Picture]>(value: [])
    private let pageSubject = BehaviorSubject<Int?>(value: 1)
    private let bag = DisposeBag()

    private let updateUISubject = PublishSubject<Void>()
    var updateUIObservable: Observable<Void> {
        Observable.merge(picturesSubject.map { _ in }, updateUISubject)
    }

    var pictures: [Picture] {
        (try? picturesSubject.value()) ?? []
    }

    var title: String? { search.text }

    init(search: Search,
         picturesRepository: PicturesRepositoryProtocol) {
        self.search = search
        self.picturesRepository = picturesRepository
        bind()
    }

    private func bind() {
        pageSubject.asObservable()
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] page in
                self?.fetchPictures(page: page)
            }).disposed(by: bag)
    }

    func loadNextPage() {
        guard let prevPage = try? pageSubject.value() else { return }

        pageSubject.onNext(prevPage + 1)
    }

    private func fetchPictures(page: Int) {
        picturesRepository.searchPictures(text: search.text, limit: Config.limit, page: page)
            .subscribe(onSuccess: { [weak self] result in
                let newPictures = result.pictures
                guard !newPictures.isEmpty else {
                    self?.pageSubject.onNext(nil)
                    return
                }

                let prevPictures = self?.pictures ?? []
                self?.picturesSubject.onNext(prevPictures + newPictures)
            }).disposed(by: bag)
    }
}
