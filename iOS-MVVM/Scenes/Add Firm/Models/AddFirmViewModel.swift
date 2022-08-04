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

class AddFirmViewModel {
    
    private let disposeBag = DisposeBag()
    var registerTriggered: PublishSubject<Void> = .init()
    
    // MARK: - Inputs
    let cui = BehaviorRelay(value: "")
    let name = BehaviorRelay(value: "")
    
    // MARK: - Outputs
    var isLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    var errorMsg: PublishSubject<String> = PublishSubject<String>()

    func register() {
        isLoading.onNext(true)
        if Role.currentRole == .patron {
            NetworkManager.shared.provider.rx.request(
                .addCompany(name: name.value, cui: cui.value))
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
        } else if Role.currentRole == .angajat {
            NetworkManager.shared.provider.rx.request(
                .companySignup(company_cui: cui.value))
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
        
    }

    deinit {
        Log.debug?.message("deinit \(self)")
    }
}
