//
//  DetteTableViewCell.swift
//  TripManager
//
//  Created by Julien ROUMAGNAC on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit

class DetteTableViewCell: UITableViewCell {

    @IBOutlet weak var endettéLabel: UILabel!
    @IBOutlet weak var creanciéLabel: UILabel!
    @IBOutlet weak var montantLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
