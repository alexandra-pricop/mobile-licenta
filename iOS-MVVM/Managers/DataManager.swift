//
//  DataManager.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 30.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Defaults

struct Firm: Codable {
    var id: Int
    var name: String
    var cui: String
    var status: String
}

struct EmployeeFirmRequest: Codable {
    var id: Int
    var status: String
    var company: Company
}

struct Company: Codable {
    var id: Int
    var status: String
    var cui: String
    var name: String
}

public enum Role {
    case contabil_sef, contabil, angajat, patron
}

extension Role {
    static var currentRole: Role {
        if DataManager.shared.userDetails.role == "contabil_sef" {
            return .contabil_sef
        }
        if DataManager.shared.userDetails.role == "contabil" {
            return .contabil
        }
        if DataManager.shared.userDetails.role == "patron" {
            return .patron
        }
        return .angajat
    }
}

class DataManager {
    static let shared = DataManager()
    private let disposeBag = DisposeBag()
    
    var currentFirm: Firm?
    var userDetails: User = User()
    var firmList: [Firm] = [Firm]()
    var firmRequests: [Firm] = [Firm]()
    var employeeFirmRequests: [EmployeeFirmRequest] = [EmployeeFirmRequest]()
    var employeeRequests: [EmployeeRequest] = [EmployeeRequest]()
    var employeeList: [Employee] = [Employee]()
    var companyDocuments: [ResponseDocument] = [ResponseDocument]()
    var currentUserRoles: [String] = [String]()
    
    func clear() {
        currentFirm = nil
        userDetails = User()
        firmList = [Firm]()
        employeeFirmRequests = [EmployeeFirmRequest]()
        employeeRequests = [EmployeeRequest]()
        employeeList = [Employee]()
        companyDocuments = [ResponseDocument]()
        currentUserRoles = [String]()
    }
}
