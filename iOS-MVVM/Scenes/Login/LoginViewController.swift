//
//  LoginViewController.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 02/02/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, StoryboardBased {

    var viewModel: LoginScreenViewModel!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        createViewModelBinding()
    }

    private func setupUI() {
        loginButton.setTitle(L10n.login, for: .normal)
        loginButton.backgroundColor = Colors.main
        loginButton.setTitleColor(Colors.white, for: .normal)
    }

    func createViewModelBinding() {
        usernameField.rx.text.orEmpty
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
