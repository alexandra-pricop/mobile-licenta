//
//  DocumentDetailsViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 08.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

class DocumentDetailsViewModel {
    
    private let disposeBag = DisposeBag()
    var document: Document
    
    init(document: Document) {
        self.document = document
    }
}
