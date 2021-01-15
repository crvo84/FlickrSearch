//
//  KingfisherImageCache.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit
import Kingfisher

class ImageCache: ImageCacheProtocol {

    static let shared = ImageCache()

    private let manager = KingfisherManager.shared

    func getImage(with url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }

        manager.retrieveImage(
            with: ImageResource(downloadURL: url),
            options: [.scaleFactor(UIScreen.main.scale)],
            progressBlock: nil,
            downloadTaskUpdated: nil
        ) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure:
                completion(nil)
            }
        }
    }
}
