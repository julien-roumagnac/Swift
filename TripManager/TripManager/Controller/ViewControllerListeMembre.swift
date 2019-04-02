//
//  ViewControllerListeMembre.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerListeMembre : UIViewController {
    var voyage : Voyage?
    
    var tableViewController: MembreTableViewController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = MembreTableViewController(tableView: self.tableView, voyage: voyage!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   /* @IBAction func addAction(_ sender: Any) {
        let cf: Membres
        let df = DateFormatter()
        df.dateFormat = "dd-mm-yyyy"
        if let bdate = df.date(from: "01-06-1988"){
            //cf = Person(firstname: "Christophe", lastname: "Fiorio", birthdate: bdate)
        }
        else{
            cf = Person(firstname: "Christophe", lastname: "Fiorio", birthdate: Date())
        }
        self.tableViewController.personsViewModel.add(person: cf)
        //self.tableView.reloadData()
    }
    @IBAction func updateAction(_ sender: Any) {
        guard let index = self.tableView.indexPathForSelectedRow else{
            return
        }
        self.tableViewController.personsViewModel.updateBirthDate(atIndexPath: index, withDate: Date())
    }*/
}
