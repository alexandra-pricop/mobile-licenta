//
//  RegisterViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 02.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import TweeTextField
import RxSwift
import CleanroomLogger

class RegisterViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var roleSwitch: UISwitch!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: TweeActiveTextField!
    @IBOutlet weak var emailTextField: TweeActiveTextField!
    @IBOutlet weak var registerButton: UIButton!
    var role: String = "patron"
    
    var viewModel: RegisterScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.backgroundColor = UIColor(hexString: "404CCF")
        registerButton.layer.cornerRadius = 20.0
        registerButton.tintColor = UIColor.white
        createViewModelBinding()
    }
    
    @IBAction func didSwitchRole(_ sender: Any) {
        if roleSwitch.isOn {
            role = "patron"
        } else {
            role = "angajat"
        }
    }

    func createViewModelBinding() {
        
        roleSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(roleSwitch.rx.value)
            .bind(to: viewModel.role)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
            .bind(onNext: viewModel.register)
            .disposed(by: disposeBag)

        viewModel.errorMsg
            .subscribe(onNext: { (value) in
                Log.error?.message(value)
                BannerNotification.showNotification(title: "Error", subtitle: value, style: .danger)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        viewModel.registerTriggered.onNext(())
    }
}
