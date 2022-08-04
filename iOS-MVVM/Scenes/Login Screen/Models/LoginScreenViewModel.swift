//
//  LoginScreenViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

struct ResponseUser: Codable {
    var user: User
}

struct User: Codable {
    var id: Int?
    var email: String?
    var name: String?
    var role: String?
}

class LoginScreenViewModel {
    
    private let disposeBag = DisposeBag()
    var loginTriggered: PublishSubject<Void> = .init()
    
    // MARK: - Inputs
    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let cancel: PublishSubject<Void> = PublishSubject<Void>()
    
    // MARK: - Outputs
    var isSuccess: PublishSubject<Bool> = PublishSubject<Bool>()
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var errorMsg: PublishSubject<String> = PublishSubject<String>()

    init() {
        AuthManager.shared.tokenChanged
            .subscribe(onNext: { [weak self] token in
                if token != nil && (token?.isValid)! {
                    self?.isLoading.onNext(false)
                    self?.isSuccess.onNext(true)
                } else {
                    self?.isLoading.onNext(false)
                    self?.isSuccess.onNext(false)
                }
            }, onError: { [weak self] error in
                Log.error?.message(error.localizedDescription)
                self?.isLoading.onNext(false)
                self?.errorMsg.onNext("error login")
            })
            .disposed(by: disposeBag)
    }
    
    func login() {
        isLoading.onNext(true)

        NetworkManager.shared.provider.rx.request(
            .login(email: email.value, password: password.value))
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                self?.isLoading.onNext(false)
                switch event {
                case .success(let response):
                    
                    let mapped: ResponseUser = try! JSONDecoder().decode(ResponseUser.self, from: response.data)
                    DataManager.shared.userDetails = mapped.user
                    print("user \(DataManager.shared.userDetails)")
                    
                    if let token = response.response?.allHeaderFields["Authorization"] as? String {
                        AuthManager.setToken(token: Token(bearerToken: token))
                        print("tokin \(AuthManager.shared.token?.bearerToken)")
                    }
                    
                    NetworkManager.shared.provider.rx.request(
                        .listCompanies)
                        .filterSuccessfulStatusCodes()
                        .subscribe { [weak self] event in
                            self?.isLoading.onNext(false)
                            switch event {
                            case .success(let response):

                                let decoder = JSONDecoder()
                                do {
                                    DataManager.shared.firmList = try decoder.decode([Firm].self, from: response.data)
                                    print("lista firme \(DataManager.shared.firmList)")
                                } catch {
                                    print(error.localizedDescription)
                                }
                                
                            case .failure(let error):
                                print("nu inteleg")
                                BannerNotification.showNotification(title: "Error",
                                                                    subtitle: error.localizedDescription,
                                                                    style: .danger)
                            }
                        }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.loginTriggered.onNext(())
                    }
                
                case .failure(let error):
                    print("nu inteleg")
                    BannerNotification.showNotification(title: "Error",
                                                        subtitle: error.localizedDescription,
                                                        style: .danger)
                }
        }
        .disposed(by: disposeBag)
    }

    deinit {
        Log.debug?.message("deinit \(self)")
    }
}
