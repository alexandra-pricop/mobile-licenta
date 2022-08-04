//
//  FirmRequestTableViewCell.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 06.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import UIKit

class FirmRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var firmCUILabel: UILabel!
    @IBOutlet weak var requestStatus: UILabel!
    @IBOutlet weak var firmNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
