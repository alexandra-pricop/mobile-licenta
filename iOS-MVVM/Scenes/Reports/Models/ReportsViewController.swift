//
//  ReportsViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 14.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable

class ReportsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var reportsTableView: UITableView!
    let categories = ["Balanta de verificare contabila", "Registru Jurnal",
                      "Carte Mare", "Jurnal Vanzari", "Jurnal Cumparari",
                      "Balanta Clienti", "Balanta Furnizori", "Registru de Casa",
                      "Extras de Banca", "Altele"]
    
    let categoriesDict = [
        "Balanta de verificare contabila": "balanta_de_verificare_contabila",
        "Registru Jurnal": "registru_jurnal",
        "Carte Mare": "carte_mare",
        "Jurnal Vanzari": "jurnal_vanzari",
        "Jurnal Cumparari": "jurnal_cumparari",
        "Balanta Clienti": "balanta_clienti",
        "Balanta Furnizori": "balanta_furnizori",
        "Registru de Casa": "registru_de_casa",
        "Extras de Banca": "extras_de_banca",
        "Altele": "alte_rapoarte"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reports"
        loadData()
        reportsTableView.dataSource = self
        reportsTableView.delegate = self
    }
    
    func loadData() {
                if let selectedFirm = DataManager.shared.currentFirm {
                NetworkManager.shared.provider.rx.request(
                    .listRolesEmployee(company_id: selectedFirm.id))
                .filterSuccessfulStatusCodes()
                .subscribe { [weak self] event in
                    switch event {
                    case .success(let response):
                        
                        let decoder = JSONDecoder()
                        do {
                            
                            DataManager.shared.currentUserRoles = try decoder.decode([String].self, from: response.data)
                            print("roluri \(DataManager.shared.currentUserRoles)")
                            
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
            }
    }
}

extension ReportsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        print("lala \(cell?.textLabel?.text)")
        if !DataManager.shared.currentUserRoles.contains(categoriesDict[(cell?.textLabel?.text)!]!) {
            let alert = UIAlertController(title: "Action not permitted", message: "You do not have access to this category", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            let alert = UIAlertController(title: "Access Granted", message: "There are no reports to show at this moment.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
