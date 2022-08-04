//
//  EmployeeDetailsCoordinator.swift
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
import RxCocoa

class EmployeeDetailsCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UINavigationController?
    private let employee: Employee
    
    init(rootViewController: UINavigationController?, employee: Employee) {
        self.employee = employee
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = EmployeeDetailsViewController.instantiate()
        let viewModel = EmployeeDetailsViewModel(employee: employee)
        viewController.viewModel = viewModel
        
        //viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
