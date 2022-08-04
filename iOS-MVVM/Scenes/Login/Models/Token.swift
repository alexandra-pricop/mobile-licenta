//
//  Token.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 02/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation

enum TokenType {
    case bearer(token: String)
    case unauthorized
}

struct Token: Codable {

    var isValid = false

    var bearerToken: String?

    enum CodingKeys: String, CodingKey {
        case isValid = "valid"
        case bearerToken = "token"
    }

    init(bearerToken: String) {
        self.bearerToken = bearerToken
        self.isValid = true
    }

    func type() -> TokenType {
        if let token = bearerToken {
            return .bearer(token: token)
        }
        return .unauthorized
    }
}
