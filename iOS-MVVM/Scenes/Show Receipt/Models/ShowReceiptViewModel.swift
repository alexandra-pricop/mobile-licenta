//
//  ShowReceiptViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 14.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import CleanroomLogger

class ShowReceiptViewModel {
    
    private let disposeBag = DisposeBag()
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}
