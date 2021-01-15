//
//  RemoteSession.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import Foundation

struct RemoteSession: Codable, Equatable {
    let token: String
}

extension RemoteSession {
    static func ==(lhs: RemoteSession, rhs: RemoteSession) -> Bool {
        return lhs.token == rhs.token
    }
}

