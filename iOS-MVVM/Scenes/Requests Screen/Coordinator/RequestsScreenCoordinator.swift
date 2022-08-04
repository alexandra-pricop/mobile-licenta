//
//  RequestsScreenCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift
 
class RequestsScreenCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UINavigationController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = RequestsScreenViewController.instantiate()
        
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
