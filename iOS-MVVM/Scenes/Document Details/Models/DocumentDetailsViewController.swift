//
//  DocumentDetailsViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import RxSwift
import RxCocoa
import DropDown

class DocumentDetailsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imaginaryButton: UIButton!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    private let disposeBag = DisposeBag()
    var viewModel: DocumentDetailsViewModel!
    
    let dropDown = DropDown()
    let dropDownValues = [
        "Facturi Clienti",
        "Facturi Furnizori",
        "Bonuri Achizitie",
        "Chitante Clienti",
        "Chitante Furnizori",
        "Extrase de Cont",
        "Altele"]
    
    let dropDownDict = [
        "Facturi Clienti": "facturi_clienti",
        "Facturi Furnizori": "facturi_furnizori",
        "Bonuri Achizitie": "bonuri_achizitie",
        "Chitante Clienti": "chitante_clienti",
        "Chitante Furnizori": "chitante_furnizori",
        "Extrase de Cont": "extrase_de_cont",
        "Altele": "alte_documente"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imaginaryButton.setTitle("", for: .normal)
        self.title = "Document Details"
        dropDown.anchorView = dropDownView
        dropDown.dataSource = dropDownValues
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownLabel.text = dropDownValues[index]
        }
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor
        descriptionTextView.layer.cornerRadius = 5.0

        dropDownView.layer.borderWidth = 0.5
        dropDownView.layer.borderColor = UIColor.gray.cgColor
        dropDownView.layer.cornerRadius = 5.0
        
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.cornerRadius = 5.0
        self.hideKeyboardWhenTappedAround()
        setCalendar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("imagine \(viewModel.document)")
    }
    
    @IBAction func showCategories(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if let selectedFirm = DataManager.shared.currentFirm {
            NetworkManager.shared.provider.rx.request(
                .uploadDocument(
                    company_id: selectedFirm.id,
                    title: nameTextField.text ?? "",
                    description: descriptionTextView.text ?? "",
                    issue_date: datePicker.date.description,
                    category: dropDownDict[dropDownLabel.text!]!,
                    file: self.viewModel.document.image!)
            )
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):

                    let alert = UIAlertController(title: "Success!", message: "Your request has been sent.", preferredStyle: UIAlertController.Style.alert)

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
            .disposed(by: disposeBag)
        } else {
            let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setCalendar() {
//        let calendar = Calendar.current
//        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
//        minDateComponent.day = 01
//        
//        let minDate = calendar.date(from: minDateComponent)
//        print(" min date : \(String(describing: minDate))")
//        datePicker.minimumDate = minDate! as Date
        
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
