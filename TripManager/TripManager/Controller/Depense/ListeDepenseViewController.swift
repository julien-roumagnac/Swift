//
//  ListeDepenseViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 29/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListeDepenseViewController : UIViewController{
    
    var tableDepenseController : DepenseTableViewController!

    var voyage : Voyage?
    
    @IBOutlet weak var titreVoyage: UILabel!
    @IBOutlet weak var tableDepense : UITableView!
    

    
    override func viewDidLoad() {
        titreVoyage.text = self.voyage?.nom
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableDepenseController = DepenseTableViewController(tableView: self.tableDepense, voyage: voyage!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
}


