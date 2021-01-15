//
//  MainViewController.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit
import RxSwift

class MainViewController: NiblessViewController {

    // MARK: - Properties

    private let viewModel: MainViewModelProtocol
    private let bag = DisposeBag()

    // children
    private let splashViewController: SplashViewController
    private var signedInViewController: SignedInViewController?

    // factories
    private let makeSignedInViewController: () -> SignedInViewController

    // MARK: - Initialization
    init(viewModel: MainViewModelProtocol,
         splashViewController: SplashViewController,
         signedInViewControllerFactory: @escaping () -> SignedInViewController) {
        self.viewModel = viewModel
        self.splashViewController = splashViewController
        self.makeSignedInViewController = signedInViewControllerFactory

        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubscriptions()
        update(viewType: .splash)
    }

    // MARK: - Setup
    private func setupSubscriptions() {
        viewModel.viewType.distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                self?.update(viewType: $0)
            }).disposed(by: bag)
    }

    // MARK: - Update
    private func update(viewType: MainViewType) {
        switch viewType {
        case .splash:
            presentSplashScreen()
        case .signedIn(let session):
            guard signedInViewController?.presentedViewController == nil else { return }

            dismissPresentedViewControllerIfNeeded { [weak self] in
                self?.presentSignedInScreen(userSession: session)
            }
        }
    }

    private func presentSplashScreen() {
        addChildViewController(splashViewController)
    }

    private func presentSignedInScreen(userSession: UserSession) {
        let signedInViewController = makeSignedInViewController()
        signedInViewController.modalPresentationStyle = .fullScreen
        signedInViewController.modalTransitionStyle = .crossDissolve
        present(signedInViewController, animated: true) { [weak self] in
            self?.removeChildViewController(self?.splashViewController)
        }
        self.signedInViewController = signedInViewController
    }
}
