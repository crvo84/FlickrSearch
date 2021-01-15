//
//  ApiError.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 25/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public enum ApiError: Error {
    case invalidRequest(Error?)
    case invalidResponse(Error?)
    case response(Error?, statusCode: Int, data: Data?)
    case decoding(Error?)
    case unknown
}

public extension Error {
    var asApiError: ApiError? { self as? ApiError }
}
