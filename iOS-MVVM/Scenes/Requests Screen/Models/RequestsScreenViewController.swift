//
//  RequestsScreenViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import RxCocoa
import RxSwift

class RequestsScreenViewController: UIViewController, StoryboardBased {
    
    private let disposeBag = DisposeBag()
    @IBOutlet weak var requestsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Requests Screen"
        
        let nib = UINib(nibName: "RequestTableViewCell", bundle: nil)
        requestsTableView.register(nib, forCellReuseIdentifier: "RequestTableViewCell")
        requestsTableView.dataSource = self
        requestsTableView.delegate = self
        requestsTableView.reloadData()
    }
    
    func acceptCell(id: String) {
        if Role.currentRole == .patron {
            if let index = DataManager.shared.employeeRequests.firstIndex(where: {$0.id == Int(id)}) {
                if let selectedFirm = DataManager.shared.currentFirm {
                    requestsTableView?.beginUpdates()
                    NetworkManager.shared.provider.rx.request(
                        .acceptEmployeeJoin(company_id: selectedFirm.id, company_user_id: Int(id)!))
                        .filterSuccessfulStatusCodes()
                        .subscribe { [weak self] event in
                            switch event {
                            case .success(let response):
                                
                                DataManager.shared.employeeRequests.remove(at: index)
                                self?.requestsTableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                                BannerNotification.showNotification(title: "E bine",
                                                                    subtitle: "Bravo",
                                                                    style: .success)
                            
                            case .failure(let error):
                                print("nu inteleg")
                                BannerNotification.showNotification(title: "Error",
                                                                    subtitle: error.localizedDescription,
                                                                    style: .danger)
                            }
                    }
                    .disposed(by: disposeBag)
                    requestsTableView?.endUpdates()
                    requestsTableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Role.currentRole == .contabil_sef {
            if let index = DataManager.shared.firmRequests.firstIndex(where: {$0.id == Int(id)}) {
                requestsTableView?.beginUpdates()
                NetworkManager.shared.provider.rx.request(
                    .acceptCompany(request_id: Int(id)!))
                    .filterSuccessfulStatusCodes()
                    .subscribe { [weak self] event in
                        switch event {
                        case .success(let response):
                            
                            DataManager.shared.firmRequests.remove(at: index)
                            self?.requestsTableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                            BannerNotification.showNotification(title: "E bine",
                                                                subtitle: "Bravo",
                                                                style: .success)
                        
                        case .failure(let error):
                            print("nu inteleg")
                            BannerNotification.showNotification(title: "Error",
                                                                subtitle: error.localizedDescription,
                                                                style: .danger)
                        }
                }
                .disposed(by: disposeBag)
                requestsTableView?.endUpdates()
                requestsTableView.reloadData()
            }
        }
    }
    
    func deleteCell(id: String) {
        if Role.currentRole == .patron {
            if let index = DataManager.shared.employeeRequests.firstIndex(where: {$0.id == Int(id)}) {
                    if let selectedFirm = DataManager.shared.currentFirm {
                        requestsTableView?.beginUpdates()
                        NetworkManager.shared.provider.rx.request(
                            .declineEmployeeJoin(company_id: selectedFirm.id, company_user_id: Int(id)!))
                            .filterSuccessfulStatusCodes()
                            .subscribe { [weak self] event in
                                switch event {
                                case .success(let response):
                                    
                                    DataManager.shared.employeeRequests.remove(at: index)
                                    self?.requestsTableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                                    BannerNotification.showNotification(title: "E bine",
                                                                        subtitle: "Bravo",
                                                                        style: .success)
                                
                                case .failure(let error):
                                    print("nu inteleg")
                                    BannerNotification.showNotification(title: "Error",
                                                                        subtitle: error.localizedDescription,
                                                                        style: .danger)
                                }
                        }
                        .disposed(by: disposeBag)
                        requestsTableView?.endUpdates()
                        requestsTableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else if Role.currentRole == .contabil_sef {
            if let index = DataManager.shared.firmRequests.firstIndex(where: {$0.id == Int(id)}) {
                requestsTableView?.beginUpdates()
                NetworkManager.shared.provider.rx.request(
                    .rejectCompany(request_id: Int(id)!))
                    .filterSuccessfulStatusCodes()
                    .subscribe { [weak self] event in
                        switch event {
                        case .success(let response):
                            
                            DataManager.shared.firmRequests.remove(at: index)
                            self?.requestsTableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                            BannerNotification.showNotification(title: "E bine",
                                                                subtitle: "Bravo",
                                                                style: .success)
                        
                        case .failure(let error):
                            print("nu inteleg")
                            BannerNotification.showNotification(title: "Error",
                                                                subtitle: error.localizedDescription,
                                                                style: .danger)
                        }
                }
                .disposed(by: disposeBag)
                requestsTableView?.endUpdates()
                requestsTableView.reloadData()
            }
        }
    }
    
}

extension RequestsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Role.currentRole == .contabil_sef {
            return DataManager.shared.firmRequests.count
        }
        return DataManager.shared.employeeRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RequestTableViewCell", for: indexPath) as? RequestTableViewCell {
            if Role.currentRole == .contabil_sef {
                cell.nameLabel.text = DataManager.shared.firmRequests[indexPath.row].name
                cell.emailLabel.text = DataManager.shared.firmRequests[indexPath.row].cui
                cell.idLabel.text = String(DataManager.shared.firmRequests[indexPath.row].id)
            } else {
                cell.nameLabel.text = DataManager.shared.employeeRequests[indexPath.row].user.name
                cell.emailLabel.text = DataManager.shared.employeeRequests[indexPath.row].user.email
                cell.idLabel.text = String(DataManager.shared.employeeRequests[indexPath.row].id)
            }
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension RequestsScreenViewController: RequestTableViewCellDelegate {
    
    func didPressAccept(pressedAccept sender: RequestTableViewCell) {
        if let id = sender.idLabel.text {
            print("id cerere \(id)")
            acceptCell(id: id)
        } else {
            return
        }
    }
    func didPressDelete(pressedDecline sender: RequestTableViewCell) {
        if let id = sender.idLabel.text {
            print("id \(id)")
            deleteCell(id: id)
        } else {
                return
        }
    }
}
