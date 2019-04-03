//
//  DepenseFetchResultController.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import CoreData
import UIKit

class DepenseFetchResultController : NSObject, NSFetchedResultsControllerDelegate{
    var depense: [Depense]
    var tableView  : UITableView
    
    init(view : UITableView, depenses : [Depense]){
        self.depense = depenses
        self.tableView = view
        super.init()
        do{
            try self.depenseFetched.performFetch()
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    func transformId() -> [Date] {
        var idDep : [Date] = []
        for dep in self.depense{
            idDep.append(dep.dateDepense!)
        }
        return idDep
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
     lazy var depenseFetched : NSFetchedResultsController<Depense> = {
        //prepare a requet
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        let appD = UIApplication.shared.delegate as? AppDelegate
        let context = appD!.persistentContainer.viewContext
        let depense = self.transformId()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Depense.dateDepense),ascending:false)]//
        request.predicate = NSPredicate(format: "ANY dateDepense IN %@", depense)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
}
    

