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
 
class DocumentsReportsCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UIViewController
    public var viewController: UINavigationController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let documentsReportsViewController = DocumentsReportsViewController.instantiate()
        let viewModel = DocumentsReportsViewModel()
        documentsReportsViewController.viewModel = viewModel
        
        viewController = UINavigationController(rootViewController: documentsReportsViewController)
        viewController?.modalPresentationStyle = .fullScreen
        
        viewModel.reportsTriggered.subscribe(onNext: { _ in
            self.showReportsScreen()
        }).disposed(by: disposeBag)
        
        viewModel.documentsTriggered.subscribe(onNext: { _ in
            self.showDocumentsScreen()
        }).disposed(by: disposeBag)

        return .never()
    }
    
    private func showDocumentsScreen() {
        let documentsCoordinator = DocumentsCoordinator(rootViewController: viewController!)
        coordinate(to: documentsCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showReportsScreen() {
        let reportsCoordinator = ReportsCoordinator(rootViewController: viewController!)
        coordinate(to: reportsCoordinator).subscribe().disposed(by: disposeBag)
    }
}
