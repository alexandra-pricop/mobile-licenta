//
//  DocumentsReportsViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 14.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable

struct ResponseDocument: Codable {
    var id: Int
    var title: String
    var category: String
    var status: String
    var description: String
    var issue_date: String
    var file: String
}

class DocumentsReportsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var reportsButton: UIButton!
    @IBOutlet weak var documentsButton: UIButton!
    var viewModel: DocumentsReportsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Documents and Reports"
        reportsButton.backgroundColor = UIColor(hexString: "404CCF")
        reportsButton.layer.cornerRadius = 20.0
        reportsButton.tintColor = UIColor.white
        documentsButton.backgroundColor = UIColor(hexString: "404CCF")
        documentsButton.layer.cornerRadius = 20.0
        documentsButton.tintColor = UIColor.white
    }
    
    @IBAction func documentsPressed(_ sender: Any) {
        if let selectedFirm = DataManager.shared.currentFirm {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.documentsTriggered.onNext(())
            }
        } else {
            let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func reportsPressed(_ sender: Any) {
        viewModel.reportsTriggered.onNext(())
    }
}
