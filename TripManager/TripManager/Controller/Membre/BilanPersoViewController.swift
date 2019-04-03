//
//  BilanPersoViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 02/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit

class BilanPersoViewController: UIViewController {
    var membre : Membres?
    var tableDepenseViewController: TableDepenseMembreViewController!
    var tableBilanViewController: TableBilanViewController!
    
    @IBOutlet weak var nom : UILabel!
    @IBOutlet weak var depense : UILabel!
    @IBOutlet weak var messageDepart: UILabel!
    @IBOutlet weak var dateDepart: UILabel!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var balancePerso: UILabel!
    @IBOutlet weak var bouttonDelete : UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateArrivee: UILabel!
    @IBOutlet weak var tableViewBilan: UITableView!

    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.nom.text = (membre?.nom)! + "" + (membre?.prenom)!
        let depDouble : Double = membre?.dette ?? 0
        let depString : String = String(format:"%f", depDouble)
        self.depense.text = depString
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd/yyyy"
        let dateArrivee : String = dateFormatterPrint.string(from: (membre?.dateArrivee!)!)
        self.dateArrivee.text = dateArrivee
        if (membre?.dette)! >= 0.0 {
            self.balancePerso.text = "+ " + String((membre?.dette)!)
            self.balancePerso.textColor = UIColor.green
        }
        else {
            self.balancePerso.text = String((membre?.dette)!)
            self.balancePerso.textColor = UIColor.red
        }
        self.reload()
        super.viewDidLoad()
        self.setupView()
        self.tableDepenseViewController = TableDepenseMembreViewController(tableView: self.tableView, membre: self.membre!)
        self.tableBilanViewController = TableBilanViewController(tableView: self.tableViewBilan, membre: self.membre!)
        segmentedControl.selectedSegmentIndex = 0
        self.tableView.isHidden = false
        self.tableViewBilan.isHidden = true
    }
    
    func reload(){
        if membre?.dateDepart != nil {
            self.messageDepart.text = "Ce membre a quitté le voyage le :"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MM/dd/yyyy"
            let date : String = dateFormatterPrint.string(from: (membre?.dateDepart!)!)
            self.dateDepart.text = date
            self.bouttonDelete.isHidden = true
        }
        else{
            self.messageDepart.text = ""
            self.dateDepart.text = ""
        }
        //somme des paiements du membre
        var somme : Double = 0.0
        let paiementFetch = PaiementFetchResultController(membre: membre).paiementFetched.fetchedObjects
        if paiementFetch != nil {
            for paiement in paiementFetch!{
                somme = somme + paiement.montantPaye
            }
            depense.text = String(somme)
        }
        else{ depense.text = "0"}
    }
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Depenses", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Dettes", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        self.updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            self.tableView.isHidden = false
            self.tableViewBilan.isHidden = true
            //self.tableDepenseViewController.tableView.reloadData()
            //self.
        } else {
            self.tableView.isHidden = true
            self.tableViewBilan.isHidden = false
            //self.tableBilanViewController.tableView.reloadData()
        }
    }
    func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) != nil {
            if let departMembreController = segue.destination as? DepartMembreViewController {
                    departMembreController.membre = self.membre
                }
            }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.reload()
    }
    
    
    
}
