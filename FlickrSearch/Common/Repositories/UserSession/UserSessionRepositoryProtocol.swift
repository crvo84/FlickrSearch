//
//  UserSessionRepositoryProtocol.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 06/01/21.
//

import RxSwift

struct SignUpDTO: Encodable {}
struct SignInDTO: Encodable {}

protocol UserSessionRepositoryProtocol {
    func readUserSession() -> Single<UserSession?>
    func signUp(dto: SignUpDTO) -> Single<UserSession>
    func signIn(dto: SignInDTO) -> Single<UserSession>
    func signOut(userSession: UserSession) -> Completable
}
