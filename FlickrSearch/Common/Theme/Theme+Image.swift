//
//  Theme+Image.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import UIKit

extension Theme {
    enum Image: String {
        case likedIcon = "liked-icon"
        case unlikedIcon = "unliked-icon"
    }
}

// MARK: - Helper extensions

extension UIImage {
    convenience init(theme image: Theme.Image) {
        self.init(named: image.rawValue)!
    }
}
