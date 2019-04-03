//
//  TableDepenseMembreViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit

class TableDepenseMembreViewController : NSObject, UITableViewDelegate, UITableViewDataSource, PaiementSetViewModelDelegate {
    var tableView   : UITableView
    let fetchResultController : PaiementFetchResultController
    var membre : Membres?
    var paiementViewModel : PaiementSetViewModel
    
    init(tableView: UITableView, membre : Membres) {
        self.tableView        = tableView
        self.membre = membre
        self.fetchResultController = PaiementFetchResultController(membre: membre)
        self.paiementViewModel = PaiementSetViewModel(data : self.fetchResultController.paiementFetched)
        super.init()
        self.tableView.dataSource      = self
        self.paiementViewModel.delegate = self
        self.tableView.delegate = self
        
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.paiementViewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaiementCell", for: indexPath)
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - PersonSetViewModelDelegate
    //-------------------------------------------------------------------------------------------------
    // MARK: - PersonSetViewModelDelegate
    /// called when set globally changes
    func dataSetChanged(){
        self.tableView.reloadData()
    }
    /// called when a Person is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func paiementDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func paiementUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func paiementAdded(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let paiement = self.fetchResultController.paiementFetched.object(at: indexPath)
        CoreDataManager.context.delete(paiement)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    @discardableResult
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        if let paiement = self.paiementViewModel.get(paiementAt: indexPath.row){
            if let cel = cell as? PaiementMembreBilanTableViewCell {
                cel.prixP.text = String(paiement.montantPaye) + " €"
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MM/dd/yyyy"
                let date : String = dateFormatterPrint.string(from: (paiement.objectif?.dateDepense!)!)
                cel.dateP.text = date
            }
        }
        return cell }
}
