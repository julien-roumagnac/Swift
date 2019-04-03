//
//  VoyageTableViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit

class VoyageTableViewController : NSObject, UITableViewDelegate, UITableViewDataSource, VoyageSetViewModelDelegate{
    var tableView   : UITableView
    var voyageViewModel : VoyageSetViewModel
    let fetchResultController : VoyageFetchResultController
    
    init(tableView: UITableView) {
        self.tableView        = tableView
        self.fetchResultController = VoyageFetchResultController(view : tableView)
        self.voyageViewModel = VoyageSetViewModel(data : self.fetchResultController.voyageFetched)
        super.init()
        self.tableView.dataSource      = self
        self.voyageViewModel.delegate = self
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
        return self.voyageViewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoyageCellId", for: indexPath)
        // Configure the cell...
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let voyage = self.fetchResultController.voyageFetched.object(at: indexPath)
        CoreDataManager.context.delete(voyage)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        return [delete]
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - VoyageSetViewModelDelegate
    //-------------------------------------------------------------------------------------------------
    // MARK: - VoyageSetViewModelDelegate
    /// called when set globally changes
    func dataSetChanged(){
        self.tableView.reloadData()
    }
    /// called when a Voyage is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func voyageDeleted(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Voyage is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func voyageUpdated(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    /// called when a Voyage is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func voyageAdded(at indexPath: IndexPath){
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    @discardableResult
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        if let voyage = self.voyageViewModel.get(voyageAt: indexPath.row){
            if let cel = cell as? VoyageTableViewCell {
                
//                let dateFormatterPrint = DateFormatter()
//                dateFormatterPrint.dateFormat = "MM/dd/yyyy"
//                let date : String = dateFormatterPrint.string(from: voyage.dateDebut!)
                cel.nomVoyage.text = voyage.nom
                cel.dateVoyage.text = String(voyage.dateDebut!.prefix(10))
                cel.imageVoyage.image = UIImage(data: voyage.photo! )
            }
        }
        return cell
        
    }
}
