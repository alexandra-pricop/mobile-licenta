//
//  RequestTableViewCell.swift
//  iOS-MVVM
//
//  Created by Alexandra-Iulia Pricop on 05.06.2022.
//  Copyright © 2022 Tremend Software Consulting. All rights reserved.
//

import UIKit

protocol RequestTableViewCellDelegate: AnyObject {
    func didPressAccept(pressedAccept sender: RequestTableViewCell)
    func didPressDelete(pressedDecline sender: RequestTableViewCell)
}

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: RequestTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func acceptPressed(_ sender: Any) {
        print("alo")
        delegate?.didPressAccept(pressedAccept: self)
    }
    
    @IBAction func declinePressed(_ sender: Any) {
        print("alo")
        delegate?.didPressDelete(pressedDecline: self)
    }
}
