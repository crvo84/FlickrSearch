//
//  PictureCell.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit

class PictureCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    private var picture: Picture?

    override func awakeFromNib() {
        super.awakeFromNib()

        initialSetup()
    }

    private func initialSetup() {
        applyTheme(bgColor: .mainBackground)
        imageView.contentMode = .scaleAspectFill
        imageView.applyCornerRadius(.standard)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }

    func prepare(with picture: Picture) {
        self.picture = picture
        updateImage()
    }

    private func updateImage() {
        guard let url = picture?.url else { return }

        ImageCache.shared.getImage(with: url) { [weak self] in
            guard let picture = self?.picture, picture.url == url else {
                return
            }
            self?.imageView.image = $0
        }
    }
}
