//
//  PicturesRemoteServiceProtocol.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import RxSwift

protocol PicturesRemoteServiceProtocol {
    func searchPictures(text: String, limit: Int, page: Int) -> Single<PictureSearchResponse>
}
