//
//  DocumentTableViewCell.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 08.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {

    @IBOutlet weak var documentCategory: UILabel!
    @IBOutlet weak var documentName: UILabel!
    @IBOutlet weak var documentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
