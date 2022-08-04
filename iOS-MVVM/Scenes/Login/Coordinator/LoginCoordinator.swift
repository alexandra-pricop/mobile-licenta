////
////  LoginCoordinator.swift
////  iOS-MVVM
////
////  Created by Dragos Panoiu on 02/02/2019.
////  Copyright © 2019 Tremend Software Consulting. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Reusable
//import CleanroomLogger
//import RxSwift
//
//enum LoginCoordinationResult: Equatable {
//    case success(Bool)
//    case cancel
//}
//
//class LoginCoordinator: BaseCoordinator<LoginCoordinationResult> {
//    private var rootViewController: UIViewController
//    
//    init(rootViewController: UIViewController) {
//        self.rootViewController = rootViewController
//    }
//
//    override func start() -> Observable<CoordinationResult> {
//        let viewModel = LoginViewModel()
//        let viewController = LoginViewController.instantiate()
//        viewController.viewModel = viewModel
//        viewController.modalPresentationStyle = .fullScreen
//        
//        let cancel = viewModel.cancel.map { CoordinationResult.cancel }
//        let success = viewModel.isSuccess.map { CoordinationResult.success($0) }
//        
//        rootViewController.present(viewController, animated: true, completion: nil)
//        
//        return Observable.merge(cancel, success)
//            .take(1)
//            .do(onNext: { [weak self] result in
//                if result == .success(true) || result == .cancel {
//                    self?.rootViewController.presentedViewController?.dismiss(animated: true)
//                }
//            })
//    }
//}
