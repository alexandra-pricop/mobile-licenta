//
//  LoginScreenViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 02.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import CleanroomLogger
import RxCocoa
import RxSwift

class LoginScreenViewController: UIViewController, StoryboardBased {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel: LoginScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.backgroundColor = UIColor(hexString: "404CCF")
        loginButton.layer.cornerRadius = 20.0
        loginButton.tintColor = UIColor.white
        createViewModelBinding()
    }

    func createViewModelBinding() {
        emailField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
            .bind(onNext: viewModel.login)
            .disposed(by: disposeBag)

        viewModel.isLoading
            .subscribe(onNext: { (value) in
                Loader.shared.setActive(value)
            })
            .disposed(by: disposeBag)

        viewModel.errorMsg
            .subscribe(onNext: { (value) in
                Log.error?.message(value)
                BannerNotification.showNotification(title: "Error", subtitle: value, style: .danger)
            })
            .disposed(by: disposeBag)
    }

    deinit {
        Log.debug?.message("deinit \(self)")
    }
}
