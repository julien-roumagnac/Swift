//
//  DetailVoyageViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 24/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DetailVoyageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate{
   
    
    
    var voyage : Voyage?
    var remboursements : [Dette] = []
    var voyageMembres : [Membres] = []
    var maxDette : Double = 0
    
    @IBOutlet weak var detteTable: UITableView!
    @IBOutlet weak var balanceTable: UITableView!
    @IBOutlet weak var titreBilan: UILabel!
    @IBOutlet weak var imageVoyage: UIImageView!
    
     fileprivate lazy var membresFetched : NSFetchedResultsController<Membres> = {
           //prepare a requet
        let request : NSFetchRequest<Membres> = Membres.fetchRequest()
        let appD = UIApplication.shared.delegate as? AppDelegate
        let context = appD!.persistentContainer.viewContext
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Membres.dette),ascending:false)]
        request.predicate = NSPredicate(format: "destination = %@", voyage!)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
       }()
    
    override func viewDidLoad() {
        
        titreBilan.text = self.voyage?.nom
        self.imageVoyage.image = UIImage(data: (self.voyage?.photo!)!)!
        do{
            try self.membresFetched.performFetch()
        }
        catch let error as NSError{
            print("error")
        }
        var membres = membresFetched.fetchedObjects!
        print("error1")
        self.voyageMembres = membres
        print("error2")
        var bilanGVM : BilanGeneralViewModel = BilanGeneralViewModel(membres:membres)
        print("error3")
        remboursements = bilanGVM.bilan
        print("error4")
        maxDette = bilanGVM.maxDette
        print("error5")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) != nil {
            if let newDepenseController = segue.destination as? NewDepenseViewController {
                newDepenseController.voyage = voyage
            }
            if let listeDepenseController = segue.destination as? ListeDepenseViewController {
                listeDepenseController.voyage = voyage
            }
            if let membreController = segue.destination as? ViewControllerListeMembre {
                membreController.voyage = voyage
            }
        }
    }
    
    @IBAction func dettePayée(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: self.detteTable)
        let indexPath = self.detteTable.indexPathForRow(at: buttonPosition)
        self.deleteRemboursement(at: indexPath!.row)
        detteTable.reloadData()
        balanceTable.reloadData()
        
    }
    func deleteRemboursement(at: Int){
        remboursements[at].creancié.dette += remboursements[at].montant
        remboursements[at].endetté.dette -= remboursements[at].montant
        remboursements.remove(at: at)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.detteTable{
            return self.remboursements.count
            
        }else {
            return self.voyageMembres.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.detteTable
        {  let cell = self.detteTable.dequeueReusableCell(withIdentifier: "detteCell", for: indexPath) as! DetteTableViewCell
        cell.creanciéLabel.text = remboursements[indexPath.row].creancié.prenom
        cell.endettéLabel.text = remboursements[indexPath.row].endetté.prenom
        cell.montantLabel.text = remboursements[indexPath.row].montant.description + " €"
            return cell }
        else {
            let cell = self.balanceTable.dequeueReusableCell(withIdentifier: "balanceCell", for: indexPath) as! BalanceTableViewCell
            var val : Double = 0
            if self.maxDette == Double(0) {
                val = 0
            }else {
                val = (voyageMembres[indexPath.row].dette  / self.maxDette) * 75
            }
            
            cell.montantLabel.text = voyageMembres[indexPath.row].dette.description
            cell.nomLabel.text = voyageMembres[indexPath.row].prenom
            print(voyageMembres[indexPath.row].prenom,"val : " , val)
            var size = CGSize(width: val, height: 25)
            cell.CouleurLabel.bounds.size = size
            
            
            
            if val > 0 {
                cell.CouleurLabel.backgroundColor = UIColor.red
                cell.CouleurLabel.frame.origin = CGPoint(x: 200 + (150 - val), y: 6)
                print("ROUGE = x : ", CGPoint(x: 200 + (150 - val), y: 6).x," y : ",CGPoint(x: 200 + (150 - val), y: 6).y ," val : ", val)
            }
            else {
                cell.CouleurLabel.backgroundColor = UIColor.green
                
                cell.CouleurLabel.frame.origin = CGPoint(x: 200 + (150 + val), y: 6)
                print("VERT = x : ", CGPoint(x: 200 + (150 - val), y: 6).x," y : ",CGPoint(x: 200 + (150 - val), y: 6).y ," val : ", val)
                
            }
            
            
            
            return cell
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
        self.detteTable.reloadData()
        self.balanceTable.reloadData()
    }
    
    
}
