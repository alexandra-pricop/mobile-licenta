//
//  DocumentsViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 08.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class DocumentsViewModel {
    
    private let disposeBag = DisposeBag()
    var detailsTriggered: PublishSubject<ResponseDocument> = .init()
}
