//
//  EditAccountDetailsCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 06.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class EditAccountDetailsCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UINavigationController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = EditAccountDetailsViewController.instantiate()
        
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
