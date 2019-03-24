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
    func toto(){
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        let voyage = Voyage(context: context)
        voyage.nom = "Mon premier voyage"
        voyage.dateDebut = "juillet"
        do{
            try context.save()
            self.voyages.append(voyage)
        }
        catch let error as NSError{
            print("errooooor")
            return
        }
    }

    
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
    
}
