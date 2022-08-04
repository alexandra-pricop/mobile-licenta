//
//  MainScreenCoordinator.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class MainScreenCoordinator: BaseCoordinator<Void> {
    
    private var rootViewController: UIViewController
    private var tabBarController: UITabBarController!
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        tabBarController = UITabBarController()
        
        let viewControllers = [
            goToHomeScreen(viewController: tabBarController),
            goToUploadScreen(viewController: tabBarController),
            goToDocumentsScreen(viewController: tabBarController),
            goToUserProfileScreen(viewController: tabBarController)
            ].compactMap { $0 }
        
        tabBarController.viewControllers = viewControllers
        tabBarController.modalPresentationStyle = .fullScreen

        rootViewController.present(tabBarController!, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logout), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        return .never()
    }
    
    private func goToHomeScreen(viewController: UITabBarController) -> UIViewController? {
        let coordinator = HomeCoordinator(rootViewController: viewController)
        coordinate(to: coordinator).subscribe().disposed(by: disposeBag)
        
        let viewController = coordinator.viewController
        viewController?.tabBarItem = createTabItem(icon: UIImage(named: "home") ?? UIImage())
        
        return viewController
    }
    
    private func goToDocumentsScreen(viewController: UITabBarController) -> UIViewController? {
        let coordinator = DocumentsReportsCoordinator(rootViewController: viewController)
        coordinate(to: coordinator).subscribe().disposed(by: disposeBag)
        
        let viewController = coordinator.viewController
        viewController?.tabBarItem = createTabItem(icon: UIImage(named: "documents") ?? UIImage())
        
        return viewController
    }
    
    private func goToUploadScreen(viewController: UITabBarController) -> UIViewController? {
        let coordinator = UploadCoordinator(rootViewController: viewController)
        coordinate(to: coordinator).subscribe().disposed(by: disposeBag)
        
        let viewController = coordinator.viewController
        viewController?.tabBarItem = createTabItem(icon: UIImage(named: "upload") ?? UIImage())
        
        return viewController
    }
    
    private func goToUserProfileScreen(viewController: UITabBarController) -> UIViewController? {
        let coordinator = ProfileCoordinator(rootViewController: viewController)
        coordinate(to: coordinator).subscribe().disposed(by: disposeBag)
        
        let viewController = coordinator.viewController
        viewController?.tabBarItem = createTabItem(icon: UIImage(named: "profile") ?? UIImage())
        
        return viewController
    }
    
    @objc func logout() {
        AuthManager.removeToken()
        DataManager.shared.clear()
        tabBarController.dismiss(animated: true)
    }
    
    private func createTabItem(icon: UIImage) -> UITabBarItem {
        let item = UITabBarItem()
        item.image = icon
        item.title = nil
        item.imageInsets = .init(top: 20, left: 0, bottom: -6, right: 0)
        return item
    }
}
