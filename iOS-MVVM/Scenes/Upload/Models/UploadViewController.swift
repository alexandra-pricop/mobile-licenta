//
//  UploadViewController.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 04.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//


import Foundation
import Reusable
import RxSwift
import RxCocoa
import UniformTypeIdentifiers
import MobileCoreServices

class UploadViewController: UIViewController, StoryboardBased {
    
    private let disposeBag = DisposeBag()
    var viewModel: UploadViewModel!
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Upload Options"
        captureButton.backgroundColor = UIColor(hexString: "404CCF")
        captureButton.layer.cornerRadius = 20.0
        captureButton.tintColor = UIColor.white
        uploadButton.backgroundColor = UIColor(hexString: "404CCF")
        uploadButton.layer.cornerRadius = 20.0
        uploadButton.tintColor = UIColor.white
        imageButton.backgroundColor = UIColor(hexString: "404CCF")
        imageButton.layer.cornerRadius = 20.0
        imageButton.tintColor = UIColor.white
    }
    
    @IBAction func capturePressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true)
    }
    
    @IBAction func imageUpload(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        //aici sa vedem cum fac daca dau cancel sa nu se mai duc aaoclo
        present(picker, animated: true)
        }
}

extension UploadViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                guard let data = image.jpegData(compressionQuality: 0.2) else { return }
                print("imagine \(data)")
                let doc = Document(image: data)
                self.viewModel.detailsTriggered.onNext(doc)
            })
        } else {
            return
        }
    }
}

extension UploadViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            //self.viewModel.detailsTriggered.onNext((nil, nil))
        })
        if let selectedFileURL = urls.first {
             guard let document = CGPDFDocument(selectedFileURL as CFURL) else { return }
               guard let page = document.page(at: 1) else { return }

               let pageRect = page.getBoxRect(.mediaBox)
               let renderer = UIGraphicsImageRenderer(size: pageRect.size)
               let img = renderer.image { ctx in
                   UIColor.white.set()
                   ctx.fill(pageRect)

                   ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                   ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

                   ctx.cgContext.drawPDFPage(page)
               }
            
            guard let data = img.jpegData(compressionQuality: 0.5) else { return }
            let doc = Document(image: data)
            self.viewModel.detailsTriggered.onNext(doc)
            
        } else {
            return
        }
    }
}
