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

class ListeDepenseViewController : UIViewController,UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate{
    
    var voyage : Voyage?
    var depense : [Depense] = [] 
    
    @IBOutlet weak var titreVoyage: UILabel!
    
    override func viewDidLoad() {
        titreVoyage.text = self.voyage?.nom
        super.viewDidLoad()
        self.initDepense()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depense.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "depenseCell", for: indexPath) as! DepenseViewCell
        let dep = self.depense[indexPath.row]
        cell.date.text = dep.dateDepense
        cell.prix.text = dep.montant.description
        return cell
    }
    
    @IBOutlet weak var tableDepense : UITableView!
    
    func initDepense(){
        let voyageurs = self.voyage?.voyageurs?.allObjects
        guard voyageurs!.count > 0 else {return print("pas de voyageurs")}
        for voyageur in voyageurs! {
            let v = voyageur as! Membres
            let paiements = v.frais?.allObjects as! [Paiement]
            guard paiements.count > 0 else {return }
            for paiement in paiements {
                
                let dep = paiement.objectif
                if !(depense.contains(dep!)){
                    depense.append(dep!)
                }
            }
        }
    }
    
    
}


