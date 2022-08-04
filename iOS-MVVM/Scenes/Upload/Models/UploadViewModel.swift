//
//  UploadViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanroomLogger

public struct Document: Codable {
    var description: String?
    var name: String?
    var category: String?
    var image: Data?
    var date: Date?
    
    init(image: Data) {
        self.image = image
    }
    
    mutating func populateData(description: String, name: String, category: String, date: Date) {
        self.description = description
        self.name = name
        self.category = category
        self.date = date
    }
}

class UploadViewModel {
    
    private let disposeBag = DisposeBag()
    var detailsTriggered: PublishSubject<Document> = .init()
}
