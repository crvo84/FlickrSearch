//
//  PicturesGridViewController.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit
import RxSwift

class PicturesGridViewController: NiblessViewController {

    enum GridGeometry {
        static let itemsPerRow = 3
        static let contentInset: CGFloat = 8
        static let interitemSpacing: CGFloat = 8
    }

    // MARK: - Properties
    private let viewModel: PicturesGridViewModelProtocol
    private let bag = DisposeBag()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    // MARK: - Initialization
    init(viewModel: PicturesGridViewModelProtocol) {
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
        title = viewModel.title

        // theme
        view.applyTheme(bgColor: .mainBackground)
        navigationController?.applyThemeNavBar(.main)

        // table view
        view.addSubview(collectionView)
        collectionView.constraintToSuperview()
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        // album cell
        let cellNib = UINib(nibName: String(describing: PictureCell.self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: String(describing: PictureCell.self))
    }

    private func bind() {
        viewModel.updateUIObservable.subscribe(onNext: { [weak self] in
            self?.collectionView.reloadData()
        }).disposed(by: bag)
    }
}

extension PicturesGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.pictures.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: PictureCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        guard let pictureCell = cell as? PictureCell else { return cell }

        if let picture = viewModel.pictures[safe: indexPath.item] {
            pictureCell.prepare(with: picture)
        }

        return cell
    }
}

extension PicturesGridViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHorizontalInset = GridGeometry.contentInset * 2
        let totalInteritemSpacing = CGFloat(GridGeometry.itemsPerRow - 1) * GridGeometry.interitemSpacing
        let availableWidth = collectionView.bounds.width - totalHorizontalInset - totalInteritemSpacing
        let itemWidth = availableWidth / CGFloat(GridGeometry.itemsPerRow)
        let itemHeight = itemWidth

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        GridGeometry.interitemSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = GridGeometry.contentInset
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let isLastCell = indexPath.item == viewModel.pictures.count - 1
        if isLastCell {
            viewModel.loadNextPage()
        }
    }
}
