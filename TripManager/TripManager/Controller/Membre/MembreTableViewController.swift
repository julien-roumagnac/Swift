//
//  MembreViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit

class MembreTableViewController : NSObject, UITableViewDelegate, UITableViewDataSource, MembreSetViewModelDelegate {
    var tableView   : UITableView
    var membresViewModel : MembreSetViewModel
    let fetchResultController : MembreFetchResultController
   
    init(tableView: UITableView, voyage : Voyage) {
        self.tableView        = tableView
        self.fetchResultController = MembreFetchResultController(view : tableView, voyage: voyage)
        self.membresViewModel = MembreSetViewModel(data : self.fetchResultController.membreFetched)
        super.init()
        self.tableView.dataSource      = self
        self.membresViewModel.delegate = self
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
        return self.membresViewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MembreCellId", for: indexPath)
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
        let membre = self.fetchResultController.membreFetched.object(at: indexPath)
        CoreDataManager.context.delete(membre)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    @discardableResult
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        if let membre = self.membresViewModel.get(membreAt: indexPath.row){
            if let cel = cell as? MembrePresenterCell {
                cel.nomMembre.text = String((membre.nom!.prefix(1)))
                cel.prenomMembre.text = membre.prenom
                cel.dateArriveeMembre.text = membre.dateArrivee
                cel.totalDepenseMembre.text = "000"
            }
        }
        return cell }
}
