//
//  MainViewType.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import Foundation

enum MainViewType: Equatable {
    case splash
    case signedIn(userSession: UserSession)
}

extension MainViewType {

    static func ==(lhs: MainViewType, rhs: MainViewType) -> Bool {
        switch (lhs, rhs) {
        case (.splash, .splash):
            return true
        case let (.signedIn(lSession), .signedIn(rSession)):
            return lSession == rSession
        case (.splash, _), (.signedIn, _):
            return false
        }
    }
}
