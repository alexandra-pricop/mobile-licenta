//
//  HomeCoordinator.swift
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
 
class HomeCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UIViewController
    public var viewController: UINavigationController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let homeViewController = HomeViewController.instantiate()
        let viewModel = HomeViewModel()
        homeViewController.viewModel = viewModel

        viewController = UINavigationController(rootViewController: homeViewController)
        viewController?.modalPresentationStyle = .fullScreen
        
        viewModel.employeeListTriggered.subscribe(onNext: { _ in
            self.showEmployeeListScreen()
        }).disposed(by: disposeBag)
        
        viewModel.requestListTriggered.subscribe(onNext: { _ in
            self.showRequestsScreen()
        }).disposed(by: disposeBag)
        
        viewModel.switchFirmTriggered.subscribe(onNext: { _ in
            self.showFirmsScreen()
        }).disposed(by: disposeBag)
        
        return .never()
    }
    
    private func showEmployeeListScreen() {
        let employeeListCoordinator = EmployeeListCoordinator(rootViewController: viewController)
        coordinate(to: employeeListCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showRequestsScreen() {
        let requestsScreenCoordinator = RequestsScreenCoordinator(rootViewController: viewController)
        coordinate(to: requestsScreenCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showFirmsScreen() {
        let firmsScreenCoordinator = FirmListCoordinator(rootViewController: viewController)
        coordinate(to: firmsScreenCoordinator).subscribe().disposed(by: disposeBag)
    }
}
