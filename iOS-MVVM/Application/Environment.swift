//
//  Environment.swift
//  iOS-MVVM
//
//  Created by Cosmin Anghel on 04.01.2021.
//  Copyright © 2021 Tremend Software Consulting. All rights reserved.
//

import Foundation

public enum Environment {
    private enum EnvironmentKey: String {
        case baseURL = "BASE_URL"
        case timeoutInterval = "TIMEOUT_INTERVAL"
    }
    
    private static var infoDict: [String: Any] {
        guard let dict = Bundle.main.infoDictionary else { fatalError("plist file not found") }
        return dict
    }
    
    static var baseURL: String {
        return infoDict[EnvironmentKey.baseURL.rawValue] as? String ?? "https://conta-demo.herokuapp.com"
    }
    
    static var timeoutInterval: Int {
        let value = infoDict[EnvironmentKey.timeoutInterval.rawValue] as? String ?? ""
        return Int(value) ?? 30
    }
}
