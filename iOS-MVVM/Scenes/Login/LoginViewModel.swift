////
////  LoginViewModel.swift
////  iOS-MVVM
////
////  Created by Dragos Panoiu on 02/02/2019.
////  Copyright © 2019 Tremend Software Consulting. All rights reserved.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//import CleanroomLogger
//
//class LoginViewModel {
//    private let disposeBag = DisposeBag()
//
//    // MARK: - Inputs
//    let username = BehaviorRelay(value: "")
//    let password = BehaviorRelay(value: "")
//    let cancel: PublishSubject<Void> = PublishSubject<Void>()
//    
//    // MARK: - Outputs
//    var isSuccess: PublishSubject<Bool> = PublishSubject<Bool>()
//    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
//    var errorMsg: PublishSubject<String> = PublishSubject<String>()
//
//    init() {
//        AuthManager.shared.tokenChanged
//            .subscribe(onNext: { [weak self] token in
//                if token != nil && (token?.isValid)! {
//                    self?.isLoading.onNext(false)
//                    self?.isSuccess.onNext(true)
//                } else {
//                    self?.isLoading.onNext(false)
//                    self?.isSuccess.onNext(false)
//                }
//            }, onError: { [weak self] error in
//                Log.error?.message(error.localizedDescription)
//                self?.isLoading.onNext(false)
//                self?.errorMsg.onNext("error login")
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    func login() {
//        isLoading.onNext(true)
//
//        NetworkManager.shared.provider.rx.request(
//            .login(username: username.value, password: password.value)
//            )
//            .filterSuccessfulStatusCodes()
//            .map(Token.self)
//            .subscribe { [weak self] event in
//                self?.isLoading.onNext(false)
//
//                switch event {
//                case .success(let token):
//                    if token.isValid {
//                        AuthManager.setToken(token: token)
//                    }
//                case .error(let error):
//                    BannerNotification.showNotification(title: "Error",
//                                                        subtitle: error.localizedDescription,
//                                                        style: .danger)
//                }
//        }
//        .disposed(by: disposeBag)
//    }
//
//    deinit {
//        Log.debug?.message("deinit \(self)")
//    }
//}
