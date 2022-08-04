//
//  HomeViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//
struct EmployeeRequest: Codable {

    var id: Int
    var status: String
    var user: User
}

import Foundation
import Reusable
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var cuiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchFirmButton: UIButton!
    @IBOutlet weak var employeesButton: UIButton!
    @IBOutlet weak var requestsButton: UIButton!
    @IBOutlet weak var firmView: UIView!
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Firm Management"
        firmView.backgroundColor = UIColor(hexString: "404CCF")
        if Role.currentRole == .contabil_sef || Role.currentRole == .contabil || Role.currentRole == .angajat {
            employeesButton.isHidden = true
            requestsButton.isHidden = true
        }
        if DataManager.shared.firmList.isEmpty {
            nameLabel.text = "Welcome to ContaTracker!"
            cuiLabel.text = "Please add or sign up to a firm"
        } else {
            nameLabel.text = "Welcome to ContaTracker!"
            cuiLabel.text = "Please choose a firm to manage"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedCompany = DataManager.shared.currentFirm {
            nameLabel.text = selectedCompany.name
            cuiLabel.text = selectedCompany.cui
        }
    }
    
    @IBAction func requestsPressed(_ sender: Any) {
        if let selectedFirm = DataManager.shared.currentFirm {
            NetworkManager.shared.provider.rx.request(
                .listEmployeeRequests(company_id: selectedFirm.id))
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print("raspuns \(response)")
    //                    BannerNotification.showNotification(title: "Bravp",
    //                                                        subtitle: "E bine",
    //                                                        style: .success)
                    let decoder = JSONDecoder()
                    do {
                        DataManager.shared.employeeRequests = try decoder.decode([EmployeeRequest].self, from: response.data)
                        print("cereri firma \(DataManager.shared.employeeRequests)")
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.requestListTriggered.onNext(())
            }
        } else {
            let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func employeeButtonPressed(_ sender: Any) {
        if let selectedFirm = DataManager.shared.currentFirm {
            NetworkManager.shared.provider.rx.request(
                .listCompanyEmployees(company_id: selectedFirm.id))
                .filterSuccessfulStatusCodes()
                .subscribe { [weak self] event in
                    switch event {
                    case .success(let response):
                        
                        let decoder = JSONDecoder()
                        do {
                            DataManager.shared.employeeList = try decoder.decode([Employee].self, from: response.data)
                            print("lista angajati \(DataManager.shared.employeeList)")
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
            .disposed(by: disposeBag)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.employeeListTriggered.onNext(())
            }
        } else {
            let alert = UIAlertController(title: "Action not permitted", message: "Please select or add a firm", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func switchFirmPressed(_ sender: Any) {
        NetworkManager.shared.provider.rx.request(
            .listCompanies)
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):

                    let decoder = JSONDecoder()
                    do {
                        DataManager.shared.firmList = try decoder.decode([Firm].self, from: response.data)
                        print("lista firme \(DataManager.shared.firmList)")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.switchFirmTriggered.onNext(())
        }
    }
}
