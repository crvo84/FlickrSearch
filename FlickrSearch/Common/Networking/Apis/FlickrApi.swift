//
//  FlickrApi.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import Foundation

enum FlickrApi {
    case searchPhotos(text: String, limit: Int, page: Int)
}

extension FlickrApi: ApiRequest {

    var method: HTTPMethod {
        switch self {
        case .searchPhotos:
            return .get
        }
    }

    var path: String {
        switch self {
        case .searchPhotos:
            return "/services/rest"
        }
    }

    var queryParams: HTTPQueryParams? {
        switch self {
        case let .searchPhotos(text, limit, page):
            return [
                "method": "flickr.photos.search",
                "nojsoncallback": true,
                "format": "json",
                "api_key": Constants.ApiKey.flickr,
                "per_page": limit,
                "page": page,
                "text": text
            ]
        }
    }

    var body: Data? {
        switch self {
        case .searchPhotos:
            return nil
        }
    }

    var contentType: HTTPContentType? { .json }

    var headers: HTTPHeaders? { nil }

    var host: String { Constants.Host.flickr }

    var scheme: URIScheme { .https }
}
