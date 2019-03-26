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

class NewDepenseViewController : UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    var voyage : Voyage?
    
    @IBOutlet weak var nomNewDepense : UITextField!
    @IBOutlet weak var photoNewDepense : UIImageView!
    @IBOutlet weak var dateNewDepense : UIDatePicker!
    @IBOutlet weak var tableMembresDepense : UITableView!
    
    fileprivate lazy var membresFetched : NSFetchedResultsController<Membres> = {
        //prepare a requet
        let request : NSFetchRequest<Membres> = Membres.fetchRequest()
        let appD = UIApplication.shared.delegate as? AppDelegate
        let context = appD!.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Membres.nom),ascending:false)]//
        let destinationNom = voyage!.nom! ?? ""
        print(destinationNom)
        request.predicate = NSPredicate(format: "destination.nom = %@", destinationNom)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.membresFetched.performFetch()
        }
        catch let error as NSError{
            print("error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.membresFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        return section.numberOfObjects
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membreDepCell", for: indexPath) as! MembreDepenseViewCell
        print(cell)
        let membre = self.membresFetched.object(at: indexPath)
        cell.nom?.text = String((membre.nom?.prefix(1))!)
        cell.prenom?.text = membre.prenom
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableMembresDepense.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableMembresDepense.endUpdates()
        //
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        do{
            try context.save()
        }
        catch let error as NSError{
            print("errooooor")
            return
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let montant : String = nomNewDepense.text ?? ""
        let photo : UIImage? = nil
        guard (montant != "") else {return }
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        let depense = Depense(context: context)
        //depense.montant = Double(nomNewDepense)!
        //depense.photo = nil
        
        //depense.addToParticipants(<#T##value: Paiement##Paiement#>)
        /*depense.montant = nom
        depense = date.description
        voyage.photo = nil
        for membre in membres {
            voyage.addToVoyageurs(membre)
            membre.destination = voyage
        }*/
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
