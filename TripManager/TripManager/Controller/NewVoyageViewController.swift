//
//  NewVoyageViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 24/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewVoyageViewController: UIViewController, UITextFieldDelegate{
    
    var newVoyage : Voyage?
    var toolbar: UIToolbar!
    
    @IBOutlet weak var nomNewVoyage: UITextField!
    @IBOutlet weak var photoNewVoyage: UIImageView!
    @IBOutlet weak var nomNewMembre: UITextField!
    @IBOutlet weak var prenomNewMembre: UITextField!
    @IBOutlet weak var dateANewMembre: UIDatePicker!
    @IBOutlet weak var tableNewMembres: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okAction(_ sender: Any) {
    }
}
