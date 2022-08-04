//
//  StartScreenViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 02.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class StartScreenViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel: StartScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.backgroundColor = UIColor(hexString: "404CCF")
        registerButton.layer.cornerRadius = 20.0
        registerButton.tintColor = UIColor.white
        loginButton.backgroundColor = UIColor(hexString: "404CCF")
        loginButton.layer.cornerRadius = 20.0
        loginButton.tintColor = UIColor.white
    }
    
    @IBAction func didPressLogin(_ sender: Any) {
        viewModel.loginTriggered.onNext(())
    }
    
    @IBAction func didPressRegister(_ sender: Any) {
        viewModel.registerTriggered.onNext(())
    }
}
