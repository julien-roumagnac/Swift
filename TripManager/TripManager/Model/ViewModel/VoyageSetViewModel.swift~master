//
//  VoyageSetViewModel.swift
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
/// Delegate to simulate reactive programming to change of voyage set
protocol VoyageSetViewModelDelegate {
    
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    
    /// called when a Voyage is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func voyageDeleted(at indexPath: IndexPath)
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func voyageUpdated(at indexPath: IndexPath)
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func voyageAdded(at indexPath: IndexPath)
}
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class VoyageSetViewModel{
    // MARK: -
    var delegate : VoyageSetViewModelDelegate? = nil
    var voyageFetch : NSFetchedResultsController<Voyage>
    init(data: NSFetchedResultsController<Voyage>){
        self.voyageFetch = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new membre in set of membres
    ///
    /// - Parameter membre: Membre to be added
    public func add(voyage: Voyage){
        if let indexPath = self.voyageFetch.indexPath(forObject: voyage){
            self.delegate?.voyageAdded(at: indexPath)
        } }
    
    public var count : Int {
        return self.voyageFetch.fetchedObjects?.count ?? 0
    }
    
    public func get(voyageAt index: Int) -> Voyage?{
        return self.voyageFetch.object(at: IndexPath(row: index, section: 0))
    }
    /// update departure date of Membre
    ///
    /// - Parameters:
    ///   - indexPath: (section,row) of Membre we want to update the departure date
    ///   - date: departure date
    public func updateEndDate(atIndexPath indexPath: IndexPath, withDate date: Date){
        let voyage = self.voyageFetch.object(at: indexPath)
        voyage.dateFin = date.description
        self.delegate?.voyageUpdated(at: indexPath)
    } }

