//
//  UserSessionRepository.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import RxSwift

class DemoUserSessionRepository: UserSessionRepositoryProtocol {
    func readUserSession() -> Single<UserSession?> {
        .just(.demo)
    }

    func signUp(dto: SignUpDTO) -> Single<UserSession> {
        .just(.demo)
    }

    func signIn(dto: SignInDTO) -> Single<UserSession> {
        .just(.demo)
    }

    func signOut(userSession: UserSession) -> Completable {
        .empty()
    }
}

extension UserSession {
    static var demo: UserSession {
        let profile = UserProfile(email: "flickr-demo@mymail.com")
        let session = RemoteSession(token: "qwerty1234")

        return UserSession(userProfile: profile, remoteSession: session)
    }
}
