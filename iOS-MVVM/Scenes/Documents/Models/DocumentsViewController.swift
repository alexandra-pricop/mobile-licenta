//
//  DocumentsViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import RxSwift
import RxCocoa
import Kingfisher
import MonthYearPicker

class DocumentsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var datePicker: MonthYearPickerView!
    @IBOutlet weak var documentsTableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel: DocumentsViewModel!
    var selectedDate: String = ""
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
        self.navigationItem.title = "Documents"
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DocumentTableViewCell", bundle: nil)
        documentsTableView.register(nib, forCellReuseIdentifier: "DocumentTableViewCell")
        documentsTableView.dataSource = self
        documentsTableView.delegate = self
        documentsTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        documentsTableView.reloadData()
        getDocuments()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        documentsTableView.reloadData()
        datePicker.setDate(Date(), animated: false)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.selectedDate = dateFormatter.string(from: datePicker.date)
        getDocuments()
    }
    
    @IBAction func didSelectDate(_ sender: MonthYearPickerView) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print("data selectata \(dateFormatter.string(from: sender.date))")
        self.selectedDate = dateFormatter.string(from: sender.date)
        getDocuments()
    }
    
    func getDocuments() {
        if let selectedFirm = DataManager.shared.currentFirm {
            NetworkManager.shared.provider.rx.request(
                .listDocuments(company_id: selectedFirm.id, current_date: self.selectedDate))
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print("raspuns \(response)")
                    
                    let decoder = JSONDecoder()
                    do {
                        DataManager.shared.companyDocuments = try decoder.decode([ResponseDocument].self, from: response.data)
                        print("documente firma \(DataManager.shared.companyDocuments)")
                        self?.documentsTableView.reloadData()

                    } catch {
                        print(error.localizedDescription)
                    }
                
                case .failure(let error):
                    print("nu inteleg")
                    BannerNotification.showNotification(title: "Error",
                                                        subtitle: error.localizedDescription,
                                                        style: .danger)
                }
            }
           
        } else {
            let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DocumentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataManager.shared.companyDocuments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCell", for: indexPath) as? DocumentTableViewCell {
            //print("document data \(DataManager.shared.companyDocuments)")
            cell.documentName.text = DataManager.shared.companyDocuments[indexPath.row].title
            cell.documentCategory.text = categoriesDict[DataManager.shared.companyDocuments[indexPath.row].category]
            let url = URL(string: DataManager.shared.companyDocuments[indexPath.row].file)
            cell.documentImage.kf.setImage(with: url)
            return cell
        }
        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.detailsTriggered.onNext(DataManager.shared.companyDocuments[indexPath.row])
    }
}
