//
//  ImageCache.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 12/01/21.
//

import UIKit

protocol ImageCacheProtocol {
    func getImage(with url: URL?, completion: @escaping (UIImage?) -> Void)
}

