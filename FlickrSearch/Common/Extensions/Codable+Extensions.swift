//
//  Codable+Extensions.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 15/01/21.
//

import Foundation

extension KeyedDecodingContainer where K : CodingKey {
    func decodeInt(forKey key: KeyedDecodingContainer<K>.Key) throws -> Int {
        do {
            return try self.decode(Int.self, forKey: key)
        } catch {
            let str = try self.decode(String.self, forKey: key)
            guard let value = Int(str) else {
                let desc = "Expected to decode Int/string but found data instead."
                let context = DecodingError.Context(codingPath: [key], debugDescription: desc)
                throw DecodingError.typeMismatch(Int.self, context)
            }
            return value
        }
    }
}

