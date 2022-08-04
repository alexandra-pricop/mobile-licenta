//
//  LoginScreenCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 02.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class LoginScreenCoordinator: BaseCoordinator<Void> {
    
    public var rootViewController: UINavigationController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = LoginScreenViewController.instantiate()
        let viewModel = LoginScreenViewModel()
        
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(viewController, animated: true)
        
        viewModel.loginTriggered.subscribe(onNext: { _ in
            self.showMainScreen()
        }).disposed(by: disposeBag)
        
        return .never()
    }
    
    private func showMainScreen() {
        let mainScreenCoordinator = MainScreenCoordinator(rootViewController: rootViewController!)
        coordinate(to: mainScreenCoordinator).subscribe().disposed(by: disposeBag)
    }
}
