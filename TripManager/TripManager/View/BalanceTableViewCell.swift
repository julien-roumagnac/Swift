//
//  BalanceTableViewCell.swift
//  TripManager
//
//  Created by Julien ROUMAGNAC on 02/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var montantLabel: UILabel!
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var CouleurLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
