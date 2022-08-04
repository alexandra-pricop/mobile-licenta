//
//  AppCoordinator.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 02/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController.instantiate()
        viewController.viewModel = viewModel
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.showStartScreen(on: viewController)

        return .never()
    }
    
    private func showMainScreen(on rootViewController: UIViewController) {
        let mainCoordinator = MainScreenCoordinator(rootViewController: rootViewController)
        coordinate(to: mainCoordinator).subscribe().disposed(by: disposeBag)
    }
    
    private func showStartScreen(on rootViewController: UIViewController) {
        let startCoordinator = StartScreenCoordinator(rootViewController: rootViewController)
        coordinate(to: startCoordinator).subscribe().disposed(by: disposeBag)
    }

}
