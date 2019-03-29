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
        let destinationNom = voyage!.nom! 
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
        let membre = self.membresFetched.object(at: indexPath)
        cell.nom?.text = String((membre.nom?.prefix(1))!)
        cell.prenom?.text = membre.prenom
        cell.montantDu?.text = "0"
        cell.montantPaye?.text = "0"
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
        //let photo : UIImage? = nil
        let date : String = dateNewDepense!.date.description
        guard (montant != "") else {return }
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        //DEPENSE
        let depense = Depense(context: context)
        depense.dateDepense = date
        depense.montant = Double(montant)!
        depense.photo = nil
        //PAIEMENT
        let cells = self.tableMembresDepense.visibleCells as! [MembreDepenseViewCell]
        for cell in cells {
            if cell.estConcerne.isOn {
                let newPaiement = Paiement(context: context)
                let nomPayeur = cell.nom.text
                let prenomPayeur = cell.prenom.text
                //trouver le membre
                let m = self.findMembre(nom: nomPayeur!, prenom: prenomPayeur!)
                guard m != nil else {print("probleme"); return}
                newPaiement.montantDu = (NumberFormatter().number(from: cell.montantDu!.text!)?.doubleValue)!
                newPaiement.montantPaye = (NumberFormatter().number(from: cell.montantPaye!.text!)?.doubleValue)!
                newPaiement.payeur = m
                depense.addToParticipants(newPaiement)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func findMembre(nom: String, prenom: String) -> Membres?{
        let membres = self.membresFetched.fetchedObjects
        for membre in membres! {
            if (nom == String((membre.nom?.prefix(1))!) && prenom == membre.prenom){
                return membre
            }
        }
        return nil
    }
    
}
