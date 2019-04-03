//
//  DepenseTableViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit

class DepenseTableViewController : NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var depense : [Depense]
    var voyage : Voyage
    var tableView   : UITableView
    var depenseViewModel : DepenseSetViewModel
    var fetchResultController : DepenseFetchResultController
    
    init(tableView: UITableView, voyage : Voyage) {
        self.voyage = voyage
        self.depense = []
        self.tableView = tableView
        self.fetchResultController = DepenseFetchResultController(view: tableView, depenses: self.depense)
        self.depenseViewModel = DepenseSetViewModel(data : self.fetchResultController.depenseFetched)
        super.init()
        self.tableView.dataSource      = self
        self.tableView.delegate = self
        self.depenseReload()
    }
    
    func depenseReload(){
        let membreFetch = MembreFetchResultController(view: tableView, voyage: voyage)
        let membres = membreFetch.membreFetched.fetchedObjects
        guard !(membres == nil) else {return}
        for membre in membres! {
            let paiementFetch = PaiementFetchResultController(membre: membre)
            let paiements = paiementFetch.paiementFetched.fetchedObjects
            if !(paiements == nil){
                for paiement in paiements!{
                    if !(self.depense.contains(paiement.objectif!)){
                        self.depense.append(paiement.objectif!)}
                }
            }
        }
        self.fetchResultController = DepenseFetchResultController(view: self.tableView, depenses: self.depense)
        }
    //-------------------------------------------------------------------------------------------------
    // MARK: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.depense.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepenseCellId", for: indexPath)
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
    func depenseDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func depenseUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func depenseAdded(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        //let depense = self.fetchResultController.depenseFetched.object(at: indexPath)
        //CoreDataManager.context.delete(depense)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    @discardableResult
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let depense = self.depense[indexPath.row]
            if let cel = cell as? DepenseViewCell {
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MM/dd/yyyy"
                let date : String = dateFormatterPrint.string(from: depense.dateDepense!)
                cel.date.text = date
                cel.prix.text = String(depense.montant)
            }
        return cell }
}
