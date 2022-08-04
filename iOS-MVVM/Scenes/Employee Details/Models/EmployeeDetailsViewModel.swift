//
//  EmployeeDetailsViewModel.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import CleanroomLogger
import RxCocoa

class EmployeeDetailsViewModel {
    
    private let disposeBag = DisposeBag()
    
    let employee: Employee
    var balanta = BehaviorRelay<Bool>(value: false)
    var registru = BehaviorRelay<Bool>(value: false)
    var carte = BehaviorRelay<Bool>(value: false)
    var vanzari = BehaviorRelay<Bool>(value: false)
    var cumparaturi = BehaviorRelay<Bool>(value: false)
    var clienti = BehaviorRelay<Bool>(value: false)
    var furnizori = BehaviorRelay<Bool>(value: false)
    var registruCasa = BehaviorRelay<Bool>(value: false)
    var extras = BehaviorRelay<Bool>(value: false)
    var altele = BehaviorRelay<Bool>(value: false)
    
    init(employee: Employee) {
        self.employee = employee
    }
    
    func save() {
        var permissions: [String] = [String]()
        if balanta.value || DataManager.shared.currentUserRoles.contains("balanta_de_verificare_contabila") {
            permissions.append("balanta_de_verificare_contabila")
        }
        if registru.value || DataManager.shared.currentUserRoles.contains("registru_jurnal") {
            permissions.append("registru_jurnal")
        }
        if carte.value || DataManager.shared.currentUserRoles.contains("carte_mare") {
            permissions.append("carte_mare")
        }
        if vanzari.value || DataManager.shared.currentUserRoles.contains("jurnal_vanzari") {
            permissions.append("jurnal_vanzari")
        }
        if cumparaturi.value || DataManager.shared.currentUserRoles.contains("jurnal_cumparari") {
            permissions.append("jurnal_cumparari")
        }
        if clienti.value || DataManager.shared.currentUserRoles.contains("balanta_clienti") {
            permissions.append("balanta_clienti")
        }
        if furnizori.value || DataManager.shared.currentUserRoles.contains("balanta_furnizori") {
            permissions.append("balanta_furnizori")
        }
        if registruCasa.value || DataManager.shared.currentUserRoles.contains("registru_de_casa") {
            permissions.append("registru_de_casa")
        }
        if extras.value || DataManager.shared.currentUserRoles.contains("extras_de_banca") {
            permissions.append("extras_de_banca")
        }
        if altele.value || DataManager.shared.currentUserRoles.contains("alte_rapoarte") {
            permissions.append("alte_rapoarte")
        }
        
        if let selectedFirm = DataManager.shared.currentFirm {
            NetworkManager.shared.provider.rx.request(
                .updateEmployeeRoles(company_id: selectedFirm.id, user_id: employee.id, roles: permissions))
                .filterSuccessfulStatusCodes()
                .subscribe { event in
                    switch event {
                    case .success(_):

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
        }
    }
}
