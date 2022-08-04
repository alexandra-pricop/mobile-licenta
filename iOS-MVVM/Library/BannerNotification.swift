//
//  BannerNotification.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 12/05/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class BannerNotification {
    
    class func showNotification(title: String, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        let duration = Double((5 * subtitle.count) / 50)
        banner.duration = duration < 5 ? 5 : duration
        banner.show()
    }
    
}
