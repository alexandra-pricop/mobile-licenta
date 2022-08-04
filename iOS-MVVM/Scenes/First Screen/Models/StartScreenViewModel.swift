//
//  StartScreenViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 02.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class StartScreenViewModel {
    
    private let disposeBag = DisposeBag()
    var loginTriggered: PublishSubject<Void> = .init()
    var registerTriggered: PublishSubject<Void> = .init()
}
