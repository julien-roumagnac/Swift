//
//  PaiementFetchResultController.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import CoreData
import UIKit

class PaiementFetchResultController: NSObject, NSFetchedResultsControllerDelegate{
    
    var membre : Membres?
    
    init(membre : Membres?){
        self.membre = membre
        super.init()
        do{
            try self.paiementFetched.performFetch()
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    lazy var paiementFetched : NSFetchedResultsController<Paiement> = {
        //prepare a requet
        let request : NSFetchRequest<Paiement> = Paiement.fetchRequest()
        let appD = UIApplication.shared.delegate as? AppDelegate
        let context = appD!.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Paiement.montantPaye),ascending:false)]//
        request.predicate = NSPredicate(format: "payeur = %@", membre!)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    
}
