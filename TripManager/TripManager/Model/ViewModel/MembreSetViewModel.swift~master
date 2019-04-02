//
//  MembreSetViewModel.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
/// Delegate to simulate reactive programming to change of membre set
protocol MembreSetViewModelDelegate {

    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    
    /// called when a Membre is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func membreDeleted(at indexPath: IndexPath)
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func membreUpdated(at indexPath: IndexPath)
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func membreAdded(at indexPath: IndexPath)
}
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class MembreSetViewModel{
    // MARK: -
    var delegate : MembreSetViewModelDelegate? = nil
    var membreFetch : NSFetchedResultsController<Membres>
    init(data: NSFetchedResultsController<Membres>){
        self.membreFetch = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new membre in set of membres
    ///
    /// - Parameter membre: Membre to be added
    public func add(membre: Membres){
        if let indexPath = self.membreFetch.indexPath(forObject: membre){
            self.delegate?.membreAdded(at: indexPath)
        } }
    
    public var count : Int {
        return self.membreFetch.fetchedObjects?.count ?? 0
    }
    
    public func get(membreAt index: Int) -> Membres?{
        return self.membreFetch.object(at: IndexPath(row: index, section: 0))
    }
    /// update departure date of Membre
    ///
    /// - Parameters:
    ///   - indexPath: (section,row) of Membre we want to update the departure date
    ///   - date: departure date
    public func updateDepartureDate(atIndexPath indexPath: IndexPath, withDate date: Date){
        let membre = self.membreFetch.object(at: indexPath)
        membre.dateDepart = date.description
        self.delegate?.membreUpdated(at: indexPath)
    } }

