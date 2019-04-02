//
//  VoyageDAO.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//
/*
import Foundation
import CoreData

class VoyageDAO{
    
    static let request : NSFetchRequest<Voyage> = Voyage.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(voyage: Voyage){
        CoreDataManager.context.delete(voyage)
    }
    
    static func fetchAll() -> [Voyage]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        } }
    
    /// number of elements
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    static func count(forName name: String) -> Int{
        self.request.predicate = NSPredicate(format: "nom == %@", name)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    static func search(forName name: String) -> [Voyage]?{
        self.request.predicate = NSPredicate(format: "nom == %@", name)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyage]
        }
        catch{
            return nil
        } }
    
    static func count (forStartDate date: String) -> Int{
        self.request.predicate = NSPredicate(format: "dateDebut == %@", date)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    static func search(forStartDate date: String) -> [Voyage]?{
        self.request.predicate = NSPredicate(format: "dateDebut == %@", date)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyage]
        }
        catch{
            return nil
        } }
    
    static func count(forName name: String, StartDate date: String) -> Int{
        self.request.predicate = NSPredicate(format: "nom == %@ AND dateDebut == %@", name, date)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forName name: String, StartDate date: String) -> [Voyage]?{
        self.request.predicate = NSPredicate(format: "nom == %@ AND dateDebut == %@", name, date)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyage]
        }
        catch{
            return nil
        } }
    
    
    
    static func search(forPerson voyage: Voyage) -> Voyage?{
        self.request.predicate = NSPredicate(format: "nom == %@ AND dateDebut == %@", voyage.nom!, voyage.dateDebut!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Voyage]
            guard result.count != 0 else { return nil }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0]
        }
        catch{
            return nil
        } }
}
*/
