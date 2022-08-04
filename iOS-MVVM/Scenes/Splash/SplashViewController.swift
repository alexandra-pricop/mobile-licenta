//
//  SplashViewController.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 12/05/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import UIKit
import Reusable
import CleanroomLogger
import RxSwift
import RxCocoa

class SplashViewController: UIViewController, StoryboardBased {
    
    var viewModel: SplashViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewModelBinding()
    }
    
    func createViewModelBinding() {

    }
    
    deinit {
        Log.debug?.message("deinit \(self)")
    }
}
