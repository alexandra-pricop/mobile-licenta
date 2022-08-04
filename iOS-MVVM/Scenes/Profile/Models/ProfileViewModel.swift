//
//  ProfileViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 06.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class ProfileViewModel {
    
    private let disposeBag = DisposeBag()
    var firmRequestsTriggered: PublishSubject<Void> = .init()
    var editAccountTriggered: PublishSubject<Void> = .init()
    var firmListTriggered: PublishSubject<Void> = .init()
    var addFirmTriggered: PublishSubject<Void> = .init()
    var logoutTriggered: PublishSubject<Void> = .init()
    var receivedRequestsTriggered: PublishSubject<Void> = .init()
}
