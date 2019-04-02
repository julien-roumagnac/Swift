//
//  BilanPersoViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 02/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit

class BilanPersoViewController: UIViewController {
    var membre : Membres?
    @IBOutlet weak var nom : UILabel!
    @IBOutlet weak var prenom : UILabel!
    @IBOutlet weak var depense : UILabel!

    override func viewDidLoad() {
        self.nom.text = membre?.nom
        self.prenom.text = membre?.prenom
        let depDouble : Double = membre?.dette ?? 0
        let depString : String = String(format:"%f", depDouble)
        self.depense.text = depString
    }

}
