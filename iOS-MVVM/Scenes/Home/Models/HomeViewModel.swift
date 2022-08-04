//
//  HomeViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    var requestListTriggered: PublishSubject<Void> = .init()
    var employeeListTriggered: PublishSubject<Void> = .init()
    var switchFirmTriggered: PublishSubject<Void> = .init()
}
