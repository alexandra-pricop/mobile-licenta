//
//  Config.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 05/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation

struct Config {    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
}
