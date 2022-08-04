//
//  ShowReceiptViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 14.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable

class ShowReceiptViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var receiptImage: UIImageView!
    public var viewModel: ShowReceiptViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        receiptImage.image = viewModel.image
    }
}

extension ShowReceiptViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.receiptImage
    }
}
