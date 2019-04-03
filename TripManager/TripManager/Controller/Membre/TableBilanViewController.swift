//
//  TableBilanViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//
import UIKit

class TableBilanViewController : NSObject, UITableViewDelegate, UITableViewDataSource, MembreSetViewModelDelegate {
    
    var dette : [Dette] = []
    var tableView   : UITableView
    let fetchResultController : MembreFetchResultController
    var membre : Membres?
    var membreViewModel : MembreSetViewModel
    var bilanViewModel : BilanGeneralViewModel
    
    init(tableView: UITableView, membre : Membres) {
        self.tableView = tableView
        self.membre = membre
        self.fetchResultController = MembreFetchResultController(view: tableView, voyage: CurrentTrip.sharedInstance!)
        self.membreViewModel = MembreSetViewModel(data : self.fetchResultController.membreFetched)
        self.bilanViewModel = BilanGeneralViewModel(membres: self.fetchResultController.membreFetched.fetchedObjects!)
        self.dette = self.bilanViewModel.bilanMembrePerso(membre: membre)
        super.init()
        self.tableView.dataSource      = self
        self.membreViewModel.delegate = self
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
        return self.dette.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetteCell", for: indexPath)
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
    func membreDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func membreUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func membreAdded(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let dette = self.fetchResultController.membreFetched.object(at: indexPath)
        CoreDataManager.context.delete(dette)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    @discardableResult
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let detteP = self.dette[indexPath.row]
            if let cel = cell as? DettePersoTableViewCell {
                cel.créancier.text = detteP.creancié.prenom
                cel.endetté.text = detteP.endetté.prenom
                cel.prix.text = String(detteP.montant)
            }
        return cell }
}

