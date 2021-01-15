//
//  FlickrPictureSearchResponse.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import Foundation

struct FlickrPictureSearchResponse: Codable {
    let page: Int
    let pageSize: Int
    let totalPages: Int
    let totalPhotos: Int
    let photos: [FlickrPicture]
}

extension FlickrPictureSearchResponse: PictureSearchResponse {
    var pictures: [Picture] { photos }
}

extension FlickrPictureSearchResponse {
    enum CodingKeys: String, CodingKey {
        case response = "photos"
        case page
        case pageSize = "perpage"
        case totalPages = "pages"
        case totalPhotos = "total"
        case photos = "photo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)

        page = try response.decodeInt(forKey: .page)
        pageSize = try response.decodeInt(forKey: .pageSize)
        totalPages = try response.decodeInt(forKey: .totalPages)
        totalPhotos = try response.decodeInt(forKey: .totalPhotos)
        photos = try response.decode([FlickrPicture].self, forKey: .photos)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)

        try response.encode(page, forKey: .page)
        try response.encode(pageSize, forKey: .pageSize)
        try response.encode(totalPages, forKey: .totalPages)
        try response.encode(totalPhotos, forKey: .totalPhotos)
        try response.encode(photos, forKey: .photos)
    }
}
