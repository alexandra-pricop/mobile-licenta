//
//  EmployeeDetailsViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import UIKit
import RxCocoa
import RxSwift
import CleanroomLogger

class EmployeeDetailsViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var alteleSwitch: UISwitch!
    @IBOutlet weak var extrasSwitch: UISwitch!
    @IBOutlet weak var registruCasaSwitch: UISwitch!
    @IBOutlet weak var furnizoriSwitch: UISwitch!
    @IBOutlet weak var clientiSwitch: UISwitch!
    @IBOutlet weak var cumparaturiSwitch: UISwitch!
    @IBOutlet weak var vanzariSwitch: UISwitch!
    @IBOutlet weak var carteSwitch: UISwitch!
    @IBOutlet weak var balantaSwitch: UISwitch!
    @IBOutlet weak var registruSwitch: UISwitch!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    private let disposeBag = DisposeBag()
    var viewModel : EmployeeDetailsViewModel!
    var roles: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employee Details"
        self.emailLabel.text = viewModel.employee.email
        self.nameLabel.text = viewModel.employee.name
//        viewModel.employee.subscribe(onNext: { employee in
//            guard let employee = employee else { return }
//            
//        }).disposed(by: disposeBag)
        loadData()
        createViewModelBinding()
    }
    
    func createViewModelBinding() {
        print("balanta \(balantaSwitch.isOn)")
        saveButton.rx.tap
            .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
            .bind(onNext: viewModel.save)
            .disposed(by: disposeBag)
        
        balantaSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(balantaSwitch.rx.value)
            .bind(to: viewModel.balanta)
            .disposed(by: disposeBag)
        
        registruSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(registruSwitch.rx.value)
            .bind(to: viewModel.registru)
            .disposed(by: disposeBag)
        
        carteSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(carteSwitch.rx.value)
            .bind(to: viewModel.carte)
            .disposed(by: disposeBag)
        
        vanzariSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(vanzariSwitch.rx.value)
            .bind(to: viewModel.vanzari)
            .disposed(by: disposeBag)
        
        cumparaturiSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(cumparaturiSwitch.rx.value)
            .bind(to: viewModel.cumparaturi)
            .disposed(by: disposeBag)
        
        clientiSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(clientiSwitch.rx.value)
            .bind(to: viewModel.clienti)
            .disposed(by: disposeBag)
        
        furnizoriSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(furnizoriSwitch.rx.value)
            .bind(to: viewModel.furnizori)
            .disposed(by: disposeBag)
        
        registruCasaSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(registruCasaSwitch.rx.value)
            .bind(to: viewModel.registruCasa)
            .disposed(by: disposeBag)
                
        extrasSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(extrasSwitch.rx.value)
            .bind(to: viewModel.extras)
            .disposed(by: disposeBag)
        
        alteleSwitch.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(alteleSwitch.rx.value)
            .bind(to: viewModel.altele)
            .disposed(by: disposeBag)
    }
    
    func loadData() {
                if let selectedFirm = DataManager.shared.currentFirm {
                NetworkManager.shared.provider.rx.request(
                    .listRoles(company_id: selectedFirm.id, user_id: viewModel.employee.id))
                .filterSuccessfulStatusCodes()
                .subscribe { [weak self] event in
                    switch event {
                    case .success(let response):
                        
                        let decoder = JSONDecoder()
                        do {
                            
                            DataManager.shared.currentUserRoles = try decoder.decode([String].self, from: response.data)
                            print("roluri \(DataManager.shared.currentUserRoles)")
                            self?.setUpUI()
                            
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
    
    func setUpUI() {
        if DataManager.shared.currentUserRoles.contains("balanta_de_verificare_contabila") {
            balantaSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("balanta_clienti") {
            clientiSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("balanta_furnizori") {
            furnizoriSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("registru_jurnal") {
            registruSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("carte_mare") {
            carteSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("jurnal_vanzari") {
            vanzariSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("jurnal_cumparari") {
            cumparaturiSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("registru_de_casa") {
            registruCasaSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("extras_de_banca") {
            extrasSwitch.isOn = true
        }
        if DataManager.shared.currentUserRoles.contains("alte_rapoarte") {
            alteleSwitch.isOn = true
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Changes Saved", message: "Your details are being processed.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
