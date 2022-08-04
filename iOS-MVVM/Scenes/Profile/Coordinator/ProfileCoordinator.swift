//
//  ProfileCoordinator.swift
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
 
class ProfileCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UIViewController
    public var viewController: UINavigationController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let profileViewController = ProfileViewController.instantiate()
        let viewModel = ProfileViewModel()
        
        profileViewController.viewModel = viewModel
        
        viewController = UINavigationController(rootViewController: profileViewController)
        viewController?.modalPresentationStyle = .fullScreen
        
        viewModel.firmListTriggered.subscribe(onNext: { _ in
            self.showFirmListScreen()
        }).disposed(by: disposeBag)
        
        viewModel.addFirmTriggered.subscribe(onNext: { _ in
            self.showAddFirmScreen()
        }).disposed(by: disposeBag)
        
        viewModel.firmRequestsTriggered.subscribe(onNext: { _ in
            self.showFirmRequestsScreen()
        }).disposed(by: disposeBag)
        
        viewModel.editAccountTriggered.subscribe(onNext: { _ in
            self.showEditAccountScreen()
        }).disposed(by: disposeBag)
        
        viewModel.receivedRequestsTriggered.subscribe(onNext: { _ in
            self.showRequestsScreen()
        }).disposed(by: disposeBag)
        
        viewModel.logoutTriggered.subscribe(onNext: { _ in
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        }).disposed(by: disposeBag)
                                
        return .never()
    }
    
    private func showAddFirmScreen() {
        let addFirmCoordinator = AddFirmCoordinator(rootViewController: viewController)
        coordinate(to: addFirmCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showFirmListScreen() {
        let firmListCoordinator = FirmListCoordinator(rootViewController: viewController)
        coordinate(to: firmListCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showEditAccountScreen() {
        let editFirmCoordinator = EditAccountDetailsCoordinator(rootViewController: viewController)
        coordinate(to: editFirmCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showFirmRequestsScreen() {
        let firmRequestsCoordinator = FirmRequestsCoordinator(rootViewController: viewController)
        coordinate(to: firmRequestsCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showRequestsScreen() {
        let requestsScreenCoordinator = RequestsScreenCoordinator(rootViewController: viewController)
        coordinate(to: requestsScreenCoordinator).subscribe().disposed(by: disposeBag)
    }
}
