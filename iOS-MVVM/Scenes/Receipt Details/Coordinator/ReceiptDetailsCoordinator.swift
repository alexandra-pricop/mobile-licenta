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

class ReceiptDetailsCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UINavigationController?
    private var document: ResponseDocument
    
    init(rootViewController: UINavigationController?, document: ResponseDocument) {
        self.rootViewController = rootViewController
        self.document = document
    }
    
    override func start() -> Observable<Void> {
        let viewController = ReceiptDetailsViewController.instantiate()
        let viewModel = ReceiptDetailsViewModel(document: document)
        viewController.viewModel = viewModel
        
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        viewModel.showImage.subscribe(onNext: { [weak self] image in
            self?.showReceiptScreen(for: image)
        }).disposed(by: disposeBag)
        
        return .never()
    }
    
    private func showReceiptScreen(for image: UIImage) {
        let showReceiptCoordinator = ShowReceiptCoordinator(rootViewController: rootViewController, image: image)
        coordinate(to: showReceiptCoordinator).subscribe().disposed(by: disposeBag)
    }
}
