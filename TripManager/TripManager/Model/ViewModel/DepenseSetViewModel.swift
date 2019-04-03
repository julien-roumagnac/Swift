//
//  DepenseSetViewModel.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
/// Delegate to simulate reactive programming to change of voyage set
protocol DepenseSetViewModelDelegate {
    
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    
    /// called when a Voyage is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func depenseDeleted(at indexPath: IndexPath)
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func depenseUpdated(at indexPath: IndexPath)
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func depenseAdded(at indexPath: IndexPath)
}
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class DepenseSetViewModel{
    // MARK: -
    var delegate : DepenseSetViewModelDelegate? = nil
    var depenseFetch : NSFetchedResultsController<Depense>
    init(data: NSFetchedResultsController<Depense>){
        self.depenseFetch = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new membre in set of membres
    ///
    /// - Parameter membre: Membre to be added
    public func add(depense: Depense){
        if let indexPath = self.depenseFetch.indexPath(forObject: depense){
            self.delegate?.depenseAdded(at: indexPath)
        } }
    
    public var count : Int {
        return self.depenseFetch.fetchedObjects?.count ?? 0
    }
    
    public func get(depenseAt index: Int) -> Depense?{
        return self.depenseFetch.object(at: IndexPath(row: index, section: 0))
    }
}

