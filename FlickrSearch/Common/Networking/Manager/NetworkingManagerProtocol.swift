//
//  NetworkingManagerProtocol.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import Foundation
import RxSwift

public protocol NetworkingManagerProtocol {
    func execute(request: ApiRequest) -> Single<Data?>
}

public extension NetworkingManagerProtocol {

    func execute<T: Decodable>(request: ApiRequest,
                               decodeType: T.Type,
                               decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
        return execute(request: request).map {
            try Self.decode(decodeType, from: $0, with: decoder)
        }
    }
}

private extension NetworkingManagerProtocol {

    static func decode<T: Decodable>(_ type: T.Type,
                                     from data: Data?,
                                     with decoder: JSONDecoder) throws -> T {
        guard let data = data else {
            throw ApiError.decoding(nil)
        }

        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw ApiError.decoding(error)
        }
    }
}
