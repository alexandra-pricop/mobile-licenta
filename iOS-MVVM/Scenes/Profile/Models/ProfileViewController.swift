//
//  ProfileViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var receivedReqButton: UIButton!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var firmReqButton: UIButton!
    @IBOutlet weak var addFirmButton: UIButton!
    @IBOutlet weak var editAccButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User Profile"
        setUpUI()
    }
    
    func setUpUI() {
        switch Role.currentRole {
        case .contabil_sef:
            roleLabel.text = "Contabil Sef"
            addFirmButton.isHidden = true
            firmReqButton.isHidden = true
        case .contabil:
            roleLabel.text = "Contabil"
            addFirmButton.isHidden = true
            firmReqButton.isHidden = true
            receivedReqButton.isHidden = true
        case .patron:
            roleLabel.text = "Asociat Firma"
            receivedReqButton.isHidden = true
            firmReqButton.setTitle("My Firm Requests", for: .normal)
            addFirmButton.setTitle("Add Firm", for: .normal)
        default:
            roleLabel.text = "Angajat Firma"
            addFirmButton.setTitle("Send Request to Firm", for: .normal)
            receivedReqButton.isHidden = true
        }
        nameLabel.text = DataManager.shared.userDetails.name
        firmReqButton.backgroundColor = UIColor(hexString: "404CCF")
        firmReqButton.layer.cornerRadius = 20.0
        firmReqButton.tintColor = UIColor.white
        receivedReqButton.backgroundColor = UIColor(hexString: "404CCF")
        receivedReqButton.layer.cornerRadius = 20.0
        receivedReqButton.tintColor = UIColor.white
        addFirmButton.backgroundColor = UIColor(hexString: "404CCF")
        addFirmButton.layer.cornerRadius = 20.0
        addFirmButton.tintColor = UIColor.white
        editAccButton.backgroundColor = UIColor(hexString: "404CCF")
        editAccButton.layer.cornerRadius = 20.0
        editAccButton.tintColor = UIColor.white
        logoutButton.layer.cornerRadius = 20.0
        logoutButton.tintColor = UIColor.white
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        viewModel.logoutTriggered.onNext(())
    }
    
    @IBAction func firmReqPressed(_ sender: Any) {
        if Role.currentRole == .patron {
            NetworkManager.shared.provider.rx.request(
                .listCompanyRequests)
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
                        DataManager.shared.firmRequests = try decoder.decode([Firm].self, from: response.data)
                        //print("date firma \(DataManager.shared.firmRequests)")
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
                self.viewModel.firmRequestsTriggered.onNext(())

            }
        } else if Role.currentRole == .angajat {
            NetworkManager.shared.provider.rx.request(
                .listPendingEmployeeRequests)
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
                        DataManager.shared.employeeFirmRequests = try decoder.decode([EmployeeFirmRequest].self, from: response.data)
                        print("date firma angajat\(DataManager.shared.employeeFirmRequests)")
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
                self.viewModel.firmRequestsTriggered.onNext(())

            }
        }
    }
    
    @IBAction func receivedReqPressed(_ sender: Any) {
        if Role.currentRole == .contabil_sef {
            NetworkManager.shared.provider.rx.request(
                .accountantListCompanyRequests)
            .filterSuccessfulStatusCodes()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print("raspuns \(response)")

                    let decoder = JSONDecoder()
                    do {
                        DataManager.shared.firmRequests = try decoder.decode([Firm].self, from: response.data)
                        //print("date firma \(DataManager.shared.firmRequests)")
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
                self.viewModel.receivedRequestsTriggered.onNext(())
            }
        }
    }
    
    @IBAction func addFirmPressed(_ sender: Any) {
        viewModel.addFirmTriggered.onNext(())
    }
    
    @IBAction func editAccPressed(_ sender: Any) {
        viewModel.editAccountTriggered.onNext(())
    }
}
