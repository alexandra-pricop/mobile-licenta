//
//  MyToken.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 15.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation

struct MyToken: Codable {
    
    var token: Token?
    var user: ResponseUser?
    
//    var isValid = false

//    var bearerToken: String?
//
//    enum CodingKeys: String, CodingKey {
//        case isValid = "valid"
//        case bearerToken = "token"
//    }
//
//    init(bearerToken: String) {
//        self.bearerToken = bearerToken
//        self.isValid = true
//    }
//
//    func type() -> TokenType {
//        if let token = bearerToken {
//            return .bearer(token: token)
//        }
//        return .unauthorized
//    }
}

