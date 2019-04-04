//
//  ListeVoyageViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 24/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListeVoyageViewController: UIViewController{
    
    var tableViewController: VoyageTableViewController!
    @IBOutlet weak var voyageTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = VoyageTableViewController(tableView: self.voyageTable)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let v = self.tableViewController.fetchResultController.voyageFetched
        if let index = self.voyageTable.indexPathForSelectedRow{
                       CurrentTrip.sharedInstance = v.object(at: index)
                       self.voyageTable.deselectRow(at: index, animated: true)
                }
        }
    
    
   
}
