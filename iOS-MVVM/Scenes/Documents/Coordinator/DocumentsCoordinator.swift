//
//  DocumentsCoordinator.swift
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
 
class DocumentsCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UINavigationController?
    public var viewController: UINavigationController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let documentsViewController = DocumentsViewController.instantiate()
        let viewModel = DocumentsViewModel()
        documentsViewController.viewModel = viewModel
        
//        viewController = UINavigationController(rootViewController: documentsViewController)
//        viewController?.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(documentsViewController, animated: true)
        
        viewModel.detailsTriggered.subscribe(onNext: { [weak self] document in
            self?.showReceiptDetailsScreen(for: document)
        }).disposed(by: disposeBag)
                                
        return .never()
    }
    
    private func showReceiptDetailsScreen(for document: ResponseDocument) {
        let receiptDetailsCoordinator = ReceiptDetailsCoordinator(rootViewController: rootViewController, document: document)
        coordinate(to: receiptDetailsCoordinator).subscribe().disposed(by: disposeBag)
    }
}
