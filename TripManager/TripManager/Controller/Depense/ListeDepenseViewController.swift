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
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.depenseFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "depenseCell", for: indexPath) as! DepenseViewCell
        let dep = self.depenseFetched.object(at: indexPath)
        cell.date.text = dep.dateDepense
        cell.prix.text = dep.montant.description
        return cell
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableDepense.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableDepense.endUpdates()
        //
        guard let context = self.getContext() else{ return }
        do{
            try context.save()
        }
        catch let error as NSError{
            print("errooooor")
            return
        }
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.tableDepense.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableDepense.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let dep = self.depenseFetched.object(at: indexPath)
        if let context = self.getContext(){
            context.delete(dep)
        }
    }
    
    func getContext() -> NSManagedObjectContext?{
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return nil
        }
        return appD.persistentContainer.viewContext
    }
    */
    
}


