//
//  DocumentsReportsViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 14.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxCocoa
import CleanroomLogger
import RxSwift

class DocumentsReportsViewModel {
    
    private let disposeBag = DisposeBag()
    var reportsTriggered: PublishSubject<Void> = .init()
    var documentsTriggered: PublishSubject<Void> = .init()

}
