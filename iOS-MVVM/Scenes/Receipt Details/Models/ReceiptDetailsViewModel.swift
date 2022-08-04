//
//  ReceiptDetailsViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 08.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class ReceiptDetailsViewModel {
    
    private let disposeBag = DisposeBag()
    var showImage: PublishSubject<UIImage> = .init()
    var document: ResponseDocument
    
    init(document: ResponseDocument) {
        self.document = document
    }
}
