//
//  EmployeeListViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import RxSwift
import RxCocoa

class EmployeeListViewController: UIViewController, StoryboardBased {
    
    @IBOutlet weak var employeesTableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel: EmployeeListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Employee List"
        employeesTableView.dataSource = self
        employeesTableView.delegate = self
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //DataManager.shared.employeeList.count
        if DataManager.shared.employeeList.count > 2 {
            return 2
        } else {
            return DataManager.shared.employeeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = DataManager.shared.employeeList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("da am apasat")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let employee = Employee(
            id: DataManager.shared.employeeList[indexPath.row].id,
            email: DataManager.shared.employeeList[indexPath.row].email,
            name: DataManager.shared.employeeList[indexPath.row].name
        )
        print(employee)
        viewModel.detailsTriggered.onNext((employee))
    }
    
}
