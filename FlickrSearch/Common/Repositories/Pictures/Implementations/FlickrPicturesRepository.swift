//
//  FlickrPicturesRepository.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import RxSwift

class FlickrPicturesRepository: PicturesRepositoryProtocol {

    let remoteService: PicturesRemoteServiceProtocol

    init(remoteService: PicturesRemoteServiceProtocol) {
        self.remoteService = remoteService
    }

    func searchPictures(text: String, limit: Int, page: Int) -> Single<PictureSearchResponse> {
        remoteService.searchPictures(text: text, limit: limit, page: page)
    }
}
