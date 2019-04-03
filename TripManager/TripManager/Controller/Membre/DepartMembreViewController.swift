//
//  DepartMembreViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit

class DepartMembreViewController: UIViewController {
   
    var membre : Membres?
    
    @IBOutlet weak var nom : UILabel!
    @IBOutlet weak var dateDepart : UIDatePicker!
    
    override func viewDidLoad() {
        self.nom.text = (membre?.nom)! + "" + (membre?.prenom)!
        super.viewDidLoad()
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.membre?.dateDepart = dateDepart.date
        do{
            try CoreDataManager.context.save()
        }
        catch let error as NSError {print(error)}
        self.dismiss(animated: true, completion: nil)
    }
}
