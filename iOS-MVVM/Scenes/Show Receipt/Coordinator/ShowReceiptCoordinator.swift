//
//  ShowReceiptCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 14.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class ShowReceiptCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UINavigationController?
    private let image: UIImage
    
    init(rootViewController: UINavigationController?, image: UIImage) {
        self.image = image
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = ShowReceiptViewController.instantiate()
        let viewModel = ShowReceiptViewModel(image: image)
        viewController.viewModel = viewModel
        
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}


