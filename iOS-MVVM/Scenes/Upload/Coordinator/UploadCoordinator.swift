//
//  UploadCoordinator.swift
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
 
class UploadCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UIViewController
    public var viewController: UINavigationController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let uploadViewController = UploadViewController.instantiate()
        let viewModel = UploadViewModel()
        uploadViewController.viewModel = viewModel

        viewController = UINavigationController(rootViewController: uploadViewController)
        viewController?.modalPresentationStyle = .fullScreen
        viewModel.detailsTriggered.subscribe(onNext: { [weak self] document in
            self?.showDocumentDetailsScreen(for: document)
        }).disposed(by: disposeBag)

        return .never()
    }
    
    private func showDocumentDetailsScreen(for document: Document) {
        let documentDetailsCoordinator = DocumentDetailsCoordinator(rootViewController: viewController, document: document)
        coordinate(to: documentDetailsCoordinator).subscribe().disposed(by: disposeBag)
    }
}
