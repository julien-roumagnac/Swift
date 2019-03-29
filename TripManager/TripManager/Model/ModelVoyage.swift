//
//  ModelVoyage.swift
//  TripManager
//
//  Created by Audrey Samson on 29/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ModelVoyage: NSObject, NSFetchedResultsControllerDelegate {
 
    var voyageTable : UITableView!
    
    init(table : UITableView){
        self.voyageTable = table
    }
    
    
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
    
    func getVoyageFetch() -> NSFetchedResultsController<Voyage>{
        return self.voyageFetched
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
    func getContext() -> NSManagedObjectContext?{
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return nil
        }
        return appD.persistentContainer.viewContext
    }
}
