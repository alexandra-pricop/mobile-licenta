//
//  DocumentDetailsCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class DocumentDetailsCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UINavigationController?
    private var document: Document
    
    init(rootViewController: UINavigationController?, document: Document) {
        self.rootViewController = rootViewController
        self.document = document
    }
    
    override func start() -> Observable<Void> {
        let viewController = DocumentDetailsViewController.instantiate()
        let viewModel = DocumentDetailsViewModel(document: document)
        viewController.viewModel = viewModel
        
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
