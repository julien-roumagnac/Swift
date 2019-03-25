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

    @IBOutlet weak var titreBilan: UILabel!
    @IBOutlet weak var titreVoyage: UILabel!
    
    override func viewDidLoad() {
        if let v = self.voyage{
            titreBilan.text = v.nom
        }
        else {
            print("pas de voyage recu")
        }
    }
}
