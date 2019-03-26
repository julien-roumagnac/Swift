//
//  NewDepenseViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 26/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//
//ZDJOQZFHIAZHVIAZGVNOAZ

import Foundation
import UIKit
import CoreData

class NewDepenseViewController : UIViewController, UITextFieldDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    var voyage : Voyage?
    
    fileprivate lazy var membresFetched : NSFetchedResultsController<Membres> = {
        //prepare a requet
        let request : NSFetchRequest<Membres> = Membres.fetchRequest()
        let appD = UIApplication.shared.delegate as? AppDelegate
        let context = appD!.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Membres.nom),ascending:false)]//
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.membresFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membreCell", for: indexPath) as! MembreTableViewCell
        let membre = self.membresFetched.object(at: indexPath)
        cell.nomMembre?.text = membre.nom
        cell.prenomMembre?.text = membre.prenom
        return cell
        
    }
    
    
    
    @IBOutlet weak var nomNewDepense : UITextField!
    @IBOutlet weak var photoNewDepense : UIImageView!
    @IBOutlet weak var dateNewDepense : UIDatePicker!
    @IBOutlet weak var tableMembresDepense : UITableView!
}
