//
//  Loader.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 12/05/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Loader {
    
    let activityData: ActivityData
    
    static let shared = Loader()
    
    private init() {
        self.activityData = ActivityData(
            size: CGSize(width: 60, height: 60),
            message: "Loading...",
            type: NVActivityIndicatorType.ballClipRotatePulse,
            color: UIColor(hexString: "#E4A024"),
            backgroundColor: UIColor.init(hexString: "#b8b8b8").withAlphaComponent(0.4),
            textColor: UIColor(hexString: "#E4A024")
        )
    }
    
    func show() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func hide() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    func setActive(_ status: Bool) {
        if status {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        } else {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    func isAnimating() -> Bool {
        return NVActivityIndicatorPresenter.sharedInstance.isAnimating
    }
}
