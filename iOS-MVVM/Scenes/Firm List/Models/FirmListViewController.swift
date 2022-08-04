//
//  FirmListViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 06.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable

protocol FirmDelegate {
    func didSelectFirm(to firm: Firm)
}

class FirmListViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var firmListTableView: UITableView!
    var viewModel: FirmListViewModel!
    public var delegate: FirmDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FirmTableViewCell", bundle: nil)
        firmListTableView.register(nib, forCellReuseIdentifier: "FirmTableViewCell")
        firmListTableView.dataSource = self
        firmListTableView.delegate = self
    }
}

extension FirmListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.firmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FirmTableViewCell", for: indexPath) as? FirmTableViewCell {
            cell.nameLabel.text = DataManager.shared.firmList[indexPath.row].name
            cell.cuiLabel.text = DataManager.shared.firmList[indexPath.row].cui
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.shared.currentFirm = DataManager.shared.firmList[indexPath.row]
        viewModel.selectFirmTriggered.onNext(())
    }
}
