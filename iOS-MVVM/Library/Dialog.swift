//
//  Dialog.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 12/05/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import PopupDialog
import SnapKit

struct Dialog {
    static func simple(title: String, message: String) {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceUp,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        
        let okButton = CancelButton(title: "OK", action: nil)
        popup.addButtons([okButton])
        
        if let topVC = UIApplication.getTopMostViewController() {
            topVC.present(popup, animated: true, completion: nil)
        }
    }
    
    static func confirmation(title: String, message: String, completion: @escaping ((_ result: Bool) -> Void)) {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceUp,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        
        let okButton = DefaultButton(title: "YES") {
            completion(true)
        }
        
        let cancelButton = CancelButton(title: "NO") {
            completion(false)
        }
        
        popup.addButtons([okButton, cancelButton])
        
        if let topVC = UIApplication.getTopMostViewController() {
            topVC.present(popup, animated: true, completion: nil)
        }
    }
}
