//
//  EmployeeListCoordinator.swift
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

class EmployeeListCoordinator: BaseCoordinator<Void> {
    private var rootViewController: UINavigationController?
    public var viewController: UINavigationController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let employeeViewController = EmployeeListViewController.instantiate()
        let viewModel = EmployeeListViewModel()
        employeeViewController.viewModel = viewModel
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(employeeViewController, animated: true)
       
        viewModel.detailsTriggered.subscribe(onNext: { [weak self] employee in
            self?.showEmployeeDetailsScreen(for: employee)
        }).disposed(by: disposeBag)

        return .never()
    }
    
    private func showEmployeeDetailsScreen(for employee: Employee) {
        let employeeDetailsCoordinator = EmployeeDetailsCoordinator(rootViewController: rootViewController, employee: employee)
        coordinate(to: employeeDetailsCoordinator).subscribe().disposed(by: disposeBag)
    }
}
