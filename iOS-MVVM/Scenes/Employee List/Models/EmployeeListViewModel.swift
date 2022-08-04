//
//  EmployeeListViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

public struct Employee: Codable {
    var id: Int
    var email: String
    var name: String
}

class EmployeeListViewModel {
    
    private let disposeBag = DisposeBag()
    var detailsTriggered: PublishSubject<Employee> = PublishSubject<Employee>()
}
