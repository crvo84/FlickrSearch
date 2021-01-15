//
//  UserSession.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import Foundation

class UserSession: Codable, Equatable {
    let userProfile: UserProfile
    let remoteSession: RemoteSession

    init(userProfile: UserProfile, remoteSession: RemoteSession) {
        self.userProfile = userProfile
        self.remoteSession = remoteSession
    }
}

extension UserSession {
    static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        lhs.remoteSession == rhs.remoteSession && lhs.userProfile == rhs.userProfile
    }
}
