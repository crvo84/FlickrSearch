//
//  ApiRequest.swift
//  VillouNetworking
//
//  Created by Carlos Villanueva Ousset on 24/06/20.
//  Copyright © 2020 Villou. All rights reserved.
//

import Foundation

public enum URIScheme: String {
    case http = "http"
    case https = "https"
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum HTTPContentType: String {
    case json = "application/json"
}

public typealias HTTPHeaders = [String: String]
public typealias HTTPQueryParams = [String: Any]

public protocol ApiRequest {

    var scheme: URIScheme { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryParams: HTTPQueryParams? { get }
    var host: String { get }
    var path: String { get }
    var body: Data? { get }
    var contentType: HTTPContentType? { get }
    
    func asURLRequest() throws -> URLRequest
}

public extension ApiRequest {

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        // url
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path

        // url params
        components.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }

        guard let url = components.url else {
            throw ApiError.invalidRequest(nil)
        }
        var req = URLRequest(url: url)

        // method
        req.httpMethod = method.rawValue

        // headers
        headers?.forEach {
            req.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        // body
        req.httpBody = body
        if let contentTypeStr = contentType?.rawValue {
            req.setValue(contentTypeStr, forHTTPHeaderField: "Content-Type")
        }

        return req
    }
}
