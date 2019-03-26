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

class ListeVoyageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    var voyages : [Voyage] = []
    
    @IBOutlet weak var voyageTable : UITableView!
    
    fileprivate lazy var voyageFetched : NSFetchedResultsController<Voyage> = {
        //prepare a requet
        let request : NSFetchRequest<Voyage> = Voyage.fetchRequest()
        let appD = UIApplication.shared.delegate as? AppDelegate
        let context = appD!.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Voyage.dateDebut),ascending:false)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.voyageFetched.performFetch()
        }
        catch let error as NSError{
            print("error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.voyageFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voyageCell", for: indexPath) as! VoyageTableViewCell
        let voyage = self.voyageFetched.object(at: indexPath)
        cell.nomVoyage?.text = voyage.nom
        cell.dateVoyage?.text = voyage.dateDebut
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle==UITableViewCell.EditingStyle.delete){
            self.voyageTable.beginUpdates()
            if self.delete(voyageat: indexPath.row){
                self.voyageTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
            self.voyageTable.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.voyageTable.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.voyageTable.endUpdates()
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
                self.voyageTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.voyageTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
    /*@IBAction func unwindToNewVoyage(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        let newVoyageController = unwindSegue.source as! NewVoyageViewController
        let nomVoyage = newVoyageController.nomNewVoyage.text ?? ""
        let date = newVoyageController.dateVoyage.date
        let membres = newVoyageController.membres
        self.saveNewVoyage(nomVoyage: nomVoyage, photo: nil,dateDepart: date, membres: membres )
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? VoyageTableViewCell) != nil {
            if let detailVoyageController = segue.destination as? DetailVoyageViewController {
                if let index = self.voyageTable.indexPathForSelectedRow{
                    detailVoyageController.voyage = self.voyageFetched.object(at: index)
                    self.voyageTable.deselectRow(at: index, animated: true)
                }
            }
        }
    }
    
    //plus utilisé
    /*
    func saveNewVoyage(nomVoyage: String,photo: UIImage?,dateDepart: Date,membres: [Membres]){
        guard let context = self.getContext() else{ return }
        let voyage = Voyage(context: context)
        voyage.nom = nomVoyage
        voyage.dateDebut = dateDepart.description
        voyage.photo = nil
        for membre in membres {
            voyage.addToVoyageurs(membre)
            membre.destination = voyage
        }
        do{
            try context.save()
            self.voyages.append(voyage)
        }
        catch let error as NSError{
            print("errooooor")
            return
        }
    }*/
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let voyage = self.voyageFetched.object(at: indexPath)
        if let context = self.getContext(){
            context.delete(voyage)
        }
    }
    
    //plus utilisé
    func delete(voyageat: Int) -> Bool{
        if let context = self.getContext(){
            let voyage = self.voyages[voyageat]
            context.delete(voyage)
            do{
                try context.save()
                self.voyages.remove(at: voyageat)
                return true
            }
            catch let error as NSError{
                print("error")
                return false
            }
        }
        return false
    }
    
    func getContext() -> NSManagedObjectContext?{
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return nil
        }
        return appD.persistentContainer.viewContext
    }
    
}
