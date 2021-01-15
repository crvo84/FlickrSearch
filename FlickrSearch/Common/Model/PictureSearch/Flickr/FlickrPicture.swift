//
//  FlickrPicture.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import Foundation

enum FlickrPictureSizeSuffix: String {
    case thumbnailSquare = "q"
    case small = "w"
    case medium = "c"
    case large = "b"
}

struct FlickrPicture: Codable {
    let id: String?
    let server: String?
    let secret: String?
}

extension FlickrPicture: Picture {

    var url: URL? {
        urlFor(size: .small)
    }

    func urlFor(size: FlickrPictureSizeSuffix) -> URL? {
        guard let id = id,
              let secret = secret,
              let server = server else {
            return nil
        }
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).jpg")
    }
}
