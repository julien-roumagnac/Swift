//
//  PaiementSetViewModel.swift
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
protocol PaiementSetViewModelDelegate {
    
    // MARK: -
    /// called when set globally changes
    func dataSetChanged()
    
    /// called when a Voyage is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func paiementDeleted(at indexPath: IndexPath)
    /// called when a Person is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func paiementUpdated(at indexPath: IndexPath)
    /// called when a Person is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func paiementAdded(at indexPath: IndexPath)
}
//----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
// MARK: -
class PaiementSetViewModel{
    // MARK: -
    var delegate : PaiementSetViewModelDelegate? = nil
    var paiementFetch : NSFetchedResultsController<Paiement>
    init(data: NSFetchedResultsController<Paiement>){
        self.paiementFetch = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new membre in set of membres
    ///
    /// - Parameter membre: Membre to be added
    public func add(paiement: Paiement){
        if let indexPath = self.paiementFetch.indexPath(forObject: paiement){
            self.delegate?.paiementAdded(at: indexPath)
        } }
    
    public var count : Int {
        return self.paiementFetch.fetchedObjects?.count ?? 0
    }
    
    public func get(paiementAt index: Int) -> Paiement?{
        return self.paiementFetch.object(at: IndexPath(row: index, section: 0))
    }
}

