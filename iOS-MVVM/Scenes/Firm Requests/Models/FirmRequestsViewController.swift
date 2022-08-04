//
//  FirmRequestsViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 06.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable

class FirmRequestsViewController: UIViewController, StoryboardBased {

    @IBOutlet weak var firmRequestsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Firm Requests"
        let nib = UINib(nibName: "FirmRequestTableViewCell", bundle: nil)
        firmRequestsTableView.register(nib, forCellReuseIdentifier: "FirmRequestTableViewCell")
        firmRequestsTableView.dataSource = self
        firmRequestsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firmRequestsTableView.reloadData()
    }
}

extension FirmRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Role.currentRole == .angajat {
            return DataManager.shared.employeeFirmRequests.count
        }
        return DataManager.shared.firmRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FirmRequestTableViewCell", for: indexPath) as? FirmRequestTableViewCell {
            if Role.currentRole == .angajat {
                cell.firmCUILabel.text = DataManager.shared.employeeFirmRequests[indexPath.row].company.cui
                cell.firmNameLabel.text = DataManager.shared.employeeFirmRequests[indexPath.row].company.name
                cell.requestStatus.text = DataManager.shared.employeeFirmRequests[indexPath.row].status
            } else {
                cell.firmCUILabel.text = DataManager.shared.firmRequests[indexPath.row].cui
                cell.firmNameLabel.text = DataManager.shared.firmRequests[indexPath.row].name
                cell.requestStatus.text = DataManager.shared.firmRequests[indexPath.row].status
            }
            if cell.requestStatus.text == "aprobat" {
                cell.requestStatus.textColor = UIColor.green
            }
            if cell.requestStatus.text == "Declined" {
                cell.requestStatus.textColor = UIColor.red
            }
            if cell.requestStatus.text == "cerere" {
                cell.requestStatus.textColor = UIColor.gray
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
