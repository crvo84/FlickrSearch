//
//  SearchPicturesViewController.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit
import RxCocoa
import RxSwift

class SearchPicturesViewController: NiblessViewController {

    enum Geometry {
        static let estimatedRowHeight: CGFloat = 50.0
    }

    // MARK: - Properties
    private let viewModel: SearchPicturesViewModelProtocol
    private let bag = DisposeBag()

    private let tableView = UITableView()

    // MARK: - Initialization
    init(viewModel: SearchPicturesViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
    }

    // MARK: - Setup
    private func setupUI() {
        title = String(localized: .homeTitle)

        // theme
        view.applyTheme(bgColor: .mainBackground)
        navigationController?.applyThemeNavBar(.main)

        // table view
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = Geometry.estimatedRowHeight
        tableView.constraintToSuperview()
        tableView.tableFooterView = UIView()

        // search pictures cell
        let cellNib = UINib(nibName: String(describing: SearchCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: String(describing: SearchCell.self))

        // search
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = String(localized: .searchPicturesPlaceholder)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.searchTextField.leftView?.tintColor = Theme.Color.mainTint.uiColor
        searchController.searchBar.searchTextField.textColor = Theme.Color.lightLabel.uiColor
    }

    private func bind() {
        viewModel.updateUIObservable.subscribe(onNext: { [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: bag)

        navigationItem.searchController?.searchBar.rx.text
            .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchTextSubject)
            .disposed(by: bag)
    }
}

extension SearchPicturesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: SearchCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        if let searchCell = cell as? SearchCell,
           let search = viewModel.searches[safe: indexPath.row] {
            searchCell.prepare(with: search)
        }

        return cell
    }
}

extension SearchPicturesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let search = viewModel.searches[safe: indexPath.row] else { return }

        viewModel.showPicturesGrid(for: search)
    }
}
