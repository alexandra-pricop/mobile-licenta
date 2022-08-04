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

class RegisterScreenViewModel {
    
    private let disposeBag = DisposeBag()
    var registerTriggered: PublishSubject<Void> = .init()
    
    // MARK: - Inputs
    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let name = BehaviorRelay(value: "")
    var role = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Outputs
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var errorMsg: PublishSubject<String> = PublishSubject<String>()

    func register() {
        isLoading.onNext(true)
        NetworkManager.shared.provider.rx.request(
            .register(name: name.value, email: email.value, password: password.value, role: role.value ? "patron" : "angajat"))
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                self?.isLoading.onNext(false)
                switch event {
                case .success(let response):

                    BannerNotification.showNotification(title: "E bine",
                                                        subtitle: "Bravo",
                                                        style: .success)
                
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
