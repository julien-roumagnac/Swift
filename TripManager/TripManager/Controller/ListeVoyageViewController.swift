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

class ListeVoyageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var voyages : [Voyage] = []
    //var test : [String] = ["test1", "test2","test1", "test2","test1", "test2"]
    
    
    @IBOutlet weak var voyageTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        let request : NSFetchRequest<Voyage> = Voyage.fetchRequest()
        do{
            try self.voyages = context.fetch(request)
        }
        catch let error as NSError{
            print("error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voyages.count
        //return self.test.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voyageCell", for: indexPath) as! VoyageTableViewCell
        //cell.nomVoyage.text = self.voyages[indexPath.row].nom
        //cell.dateVoyage.text = self.voyages[indexPath.row].dateDebut
        cell.nomVoyage?.text = self.voyages[indexPath.row].nom
        cell.dateVoyage?.text = self.voyages[indexPath.row].dateDebut
        return cell
    }
    
    @IBAction func unwindToNewVoyage(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        print("je suis créé")
        let newVoyageController = unwindSegue.source as! NewVoyageViewController
        let nomVoyage = newVoyageController.nomNewVoyage.text ?? ""
        let date = Date()
        let membres = newVoyageController.membres
        self.saveNewVoyage(nomVoyage: nomVoyage, photo: nil,dateDepart: date, membres: membres )
        self.voyageTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailVoyageViewController{
            if let cell = sender as? UITableViewCell{
                guard let index = voyageTable.indexPath(for: cell) else {
                    return
                }
                destination.voyage = voyages[index.row]
            }
        }
    }
    func saveNewVoyage(nomVoyage: String,photo: UIImage?,dateDepart: Date,membres: [Membres]){
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        let voyage = Voyage(context: context)
        voyage.nom = nomVoyage
        voyage.dateDebut = dateDepart.description
        voyage.photo = nil
        for membre in membres {
            voyage.addToVoyageurs(membre)
        }
        do{
            try context.save()
            self.voyages.append(voyage)
        }
        catch let error as NSError{
            print("errooooor")
            return
        }
    }
}
