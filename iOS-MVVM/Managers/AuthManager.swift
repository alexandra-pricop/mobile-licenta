//
//  AuthManager.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 02/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Defaults
import RxSwift

extension Defaults.Keys {
    static let token = Key<Token?>("token")
}

class AuthManager {

    static let shared = AuthManager()

    let tokenChanged = PublishSubject<Token?>()

    var token: Token? {
        get {
            return Defaults[.token]
        }
        set {
            Defaults[.token] = newValue
            tokenChanged.onNext(newValue)
        }
    }

    var hasValidToken: Bool {
        return token?.isValid == true
    }

    class func setToken(token: Token) {
        AuthManager.shared.token = token
    }

    class func removeToken() {
        AuthManager.shared.token = nil
    }

    class func tokenValidated() {
        AuthManager.shared.token?.isValid = true
    }
}
