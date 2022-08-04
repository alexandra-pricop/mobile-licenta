//
//  String.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 05/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
