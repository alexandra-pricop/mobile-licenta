//
//  ReceiptDetailsViewControllera.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 08.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable

class ReceiptDetailsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var documentImgView: UIView!
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var nimicButton: UIButton!
    var viewModel: ReceiptDetailsViewModel!
    
    let dropDownDict = [
        "Facturi Clienti": "facturi_clienti",
        "Facturi Furnizori": "facturi_furnizori",
        "Bonuri Achizitie": "bonuri_achizitie",
        "Chitante Clienti": "chitante_clienti",
        "Chitante Furnizori": "chitante_furnizori",
        "Extrase de Cont": "extrase_de_cont",
        "Altele": "alte_documente"
    ]
    
    let categoriesDict = [
        "facturi_clienti": "Facturi Clienti",
        "facturi_furnizori": "Facturi Furnizori",
        "bonuri_achizitie": "Bonuri Achizitie",
        "chitante_clienti": "Chitante Clienti",
        "chitante_furnizori": "Chitante Furnizori",
        "extrase_de_cont": "Extrase de Cont",
        "alte_documente": "Altele"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        if #available(iOS 15.0, *) {
            dateLabel.text = viewModel.document.issue_date
        } else {
            // Fallback on earlier versions
        }
        descriptionLabel.text = viewModel.document.description
        let url = URL(string: viewModel.document.file)
        documentImage.kf.setImage(with: url)
        nimicButton.setTitle("", for: .normal)
        deleteButton.backgroundColor = .clear
        deleteButton.layer.cornerRadius = 5
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.gray.cgColor
        categoryLabel.text = categoriesDict[viewModel.document.category]
        if viewModel.document.status == "document_nou" {
            statusLabel.text = "Pending"
        } else if viewModel.document.status == "document_aprobat"{
            statusLabel.text = "Approved"
        }
        if Role.currentRole == .contabil_sef || Role.currentRole == .contabil {
            deleteButton.setTitle("Approve Document", for: .normal)
            deleteButton.setTitleColor(UIColor.green, for: .normal)
        } else {
            deleteButton.isHidden = true
            //deleteButton.setTitle("Delete Document", for: .normal)
            //deleteButton.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func showImagePressed(_ sender: Any) {
        guard let image = documentImage.image else { return }
        viewModel.showImage.onNext((image))
    }
    
    @IBAction func approveDeletePressed(_ sender: Any) {
        if Role.currentRole == .contabil_sef || Role.currentRole == .contabil {
            if let selectedFirm = DataManager.shared.currentFirm {
                NetworkManager.shared.provider.rx.request(
                    .approveDocument(company_id: selectedFirm.id, document_id: viewModel.document.id))
                .filterSuccessfulStatusCodes()
                .subscribe { [weak self] event in
                    switch event {
                    case .success(let response):
                        let alert = UIAlertController(title: "Success!", message: "Document Approved", preferredStyle: UIAlertController.Style.alert)

                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { action in
                                self?.navigationController?.popViewController(animated: true)
                        }))

                        self?.present(alert, animated: true, completion: nil)
                    
                    case .failure(let error):
                        print("nu inteleg")
                        BannerNotification.showNotification(title: "Error",
                                                            subtitle: error.localizedDescription,
                                                            style: .danger)
                    }
                }
            }
        }
        
    }
}
