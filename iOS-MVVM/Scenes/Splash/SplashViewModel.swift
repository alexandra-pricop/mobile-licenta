//
//  SplashViewModel.swift
//  iOS-MVVM
//
//  Created by Dragos Panoiu on 12/05/2019.
//  Copyright © 2019 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class SplashViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Inputs
    
    // MARK: - Outputs
    let showLogin: PublishSubject<Void> = PublishSubject<Void>()
    
    init() {

    }

    deinit {
        Log.debug?.message("deinit \(self)")
    }
}
