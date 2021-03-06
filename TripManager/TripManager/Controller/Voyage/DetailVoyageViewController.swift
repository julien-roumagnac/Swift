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
    
    
    override func viewDidLoad() {
        self.voyage = CurrentTrip.sharedInstance
        titreBilan.text = self.voyage?.nom
        self.imageVoyage.image = UIImage(data: (self.voyage?.photo!)!)!

        let membreFetch = MembreFetchResultController(view: balanceTable, voyage: voyage!)
        let membres = membreFetch.membreFetched.fetchedObjects
        
        self.voyageMembres = membres ?? []
        let bilanGVM : BilanGeneralViewModel = BilanGeneralViewModel(membres:voyageMembres)
        remboursements = bilanGVM.bilan
        maxDette = bilanGVM.maxDette
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
