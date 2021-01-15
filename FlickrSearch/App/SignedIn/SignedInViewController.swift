//
//  SignedInViewController.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit
import RxSwift

class SignedInViewController: BaseNavigationController {

    // MARK: - Properties
    private let viewModel: SignedInViewModelProtocol
    private let makeSearchPicturesViewController: () -> SearchPicturesViewController
    private let makePicturesGridViewController: (Search) -> PicturesGridViewController
    private let bag = DisposeBag()

    // MARK: - Initialization
    init(viewModel: SignedInViewModelProtocol,
         searchPicturesViewControllerFactory: @escaping () -> SearchPicturesViewController,
         picturesGridViewControllerFactory: @escaping (Search) -> PicturesGridViewController) {
        self.viewModel = viewModel
        self.makeSearchPicturesViewController = searchPicturesViewControllerFactory
        self.makePicturesGridViewController = picturesGridViewControllerFactory
        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        bind()
    }

    // MARK: - Setup
    private func initialSetup() {
        view.applyTheme(bgColor: .mainBackground)
    }

    private func bind() {
        viewModel.viewType
            .subscribe(onNext: { [weak self] in
                self?.update(viewType: $0)
            }).disposed(by: bag)
    }

    // MARK: - Update
    private func update(viewType: SignedInViewType) {
        switch viewType {
        case .searchPictures:
            showSearchPictures()
        case .picturesGrid(let search):
            showPicturesGrid(for: search)
        }
    }

    private func showSearchPictures() {
        let searchPicturesViewController = makeSearchPicturesViewController()
        pushViewController(searchPicturesViewController, animated: true)
    }

    private func showPicturesGrid(for search: Search) {
        let picturesGridViewController = makePicturesGridViewController(search)
        pushViewController(picturesGridViewController, animated: true)
    }
}
