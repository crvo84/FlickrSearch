//
//  UserSessionStateHandler.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import Foundation

enum UserSessionState {
    case signedIn(userSession: UserSession)
    case notSignedIn
}

protocol UserSessionStateHandler {
    func handleUserSessionState(_ state: UserSessionState)
}
