//
//  PictureSearchResponse.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import Foundation

protocol PictureSearchResponse {
    var page: Int { get }
    var pageSize: Int { get }
    var totalPages: Int { get }
    var totalPhotos: Int { get }
    var pictures: [Picture] { get }
}
