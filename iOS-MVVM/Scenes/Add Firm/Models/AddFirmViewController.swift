//
//  AddFirmViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 06.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import Foundation
import Reusable
import RxSwift
import CleanroomLogger

class AddFirmViewController: UIViewController, StoryboardBased {
    
    private let disposeBag = DisposeBag()
    var viewModel: AddFirmViewModel!
    @IBOutlet weak var firmCUIText: UITextField!
    @IBOutlet weak var sendReqButton: UIButton!
    @IBOutlet weak var firmNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Firm"
        self.hideKeyboardWhenTappedAround()
        createViewModelBinding()
    }
    
    func createViewModelBinding() {
        
        firmCUIText.rx.text.orEmpty
            .bind(to: viewModel.cui)
            .disposed(by: disposeBag)

        firmNameText.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)

        sendReqButton.rx.tap
            .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
            .bind(onNext: viewModel.register)
            .disposed(by: disposeBag)

        viewModel.errorMsg
            .subscribe(onNext: { (value) in
                Log.error?.message(value)
                BannerNotification.showNotification(title: "Error", subtitle: value, style: .danger)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func sendReqPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Success!", message: "Your request has been sent.", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
