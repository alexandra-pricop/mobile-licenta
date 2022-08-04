//
//  StartScreenCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 02.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class StartScreenCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UIViewController
    public var navigationController: UINavigationController?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = StartScreenViewController.instantiate()
        let viewModel = StartScreenViewModel()
        
        viewController.viewModel = viewModel
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.modalPresentationStyle = .fullScreen
        
        rootViewController.present(navigationController!, animated: true)
        
        viewModel.loginTriggered.subscribe(onNext: { _ in
            self.showLoginScreen()
        }).disposed(by: disposeBag)
        
        viewModel.registerTriggered.subscribe(onNext: { _ in
            self.showRegisterScreen()
        }).disposed(by: disposeBag)
        
        return .never()
    }
    
    private func showLoginScreen() {
        let loginCoordinator = LoginScreenCoordinator(rootViewController: navigationController)
        coordinate(to: loginCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showRegisterScreen() {
        let registerCoordinator = RegisterScreenCoordinator(rootViewController: navigationController)
        coordinate(to: registerCoordinator).subscribe().disposed(by: disposeBag)
    }
}
