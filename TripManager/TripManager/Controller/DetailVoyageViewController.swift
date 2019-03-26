//
//  DetailVoyageViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 24/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailVoyageViewController: UIViewController {
    var voyage : Voyage?
    var containerController : TitreVoyageView?
    
    @IBOutlet weak var titreBilan: UILabel!
    
    
    override func viewDidLoad() {
        titreBilan.text = self.voyage?.nom
        //let titreVoyage = containerTitre as? TitreVoyageView
        containerController?.titre.text = self.voyage?.nom
    }
    
    @IBOutlet weak var containerTitre: UIView!
}
