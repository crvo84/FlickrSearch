//
//  FlickrPicturesRemoteService.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import RxSwift

class FlickrPicturesRemoteService: PicturesRemoteServiceProtocol {

    private let manager: NetworkingManagerProtocol

    init(networkingManager: NetworkingManagerProtocol) {
        self.manager = networkingManager
    }

    func searchPictures(text: String, limit: Int, page: Int) -> Single<PictureSearchResponse> {
        let req = FlickrApi.searchPhotos(text: text, limit: limit, page: page)

        return manager.execute(request: req, decodeType: FlickrPictureSearchResponse.self)
            .map { $0 as PictureSearchResponse }
    }
    
}
