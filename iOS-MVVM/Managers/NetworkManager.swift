//
//  NetworkManager.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 12/05/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var provider = MoyaProvider<ContaTrackerAPI>()
    
    init() {
        self.provider = MoyaProvider<ContaTrackerAPI>(
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        )
    }
}
