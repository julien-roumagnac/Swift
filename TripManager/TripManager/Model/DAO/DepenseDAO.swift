//
//  DepenseDAO.swift
//  TripManager
//
//  Created by Audrey Samson on 03/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import CoreData

class DepenseDAO{
 /*
    static let request : NSFetchRequest<Depense> = Depense.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(membre: Membres){
        CoreDataManager.context.delete(membre)
    }
    
    static func fetchAll() -> [Membres]?{
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
    
    static func count(forFirstname firstname: String) -> Int{
        self.request.predicate = NSPredicate(format: "prenom == %@", firstname)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    static func search(forFirstname firstname: String) -> [Membres]?{
        self.request.predicate = NSPredicate(format: "prenom == %@", firstname)
        do{
            return try CoreDataManager.context.fetch(request) as [Membres]
        }
        catch{
            return nil
        } }
    
    static func count (forLastname lastname: String) -> Int{
        self.request.predicate = NSPredicate(format: "nom == %@", lastname)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    static func search(forLastname lastname: String) -> [Membres]?{
        self.request.predicate = NSPredicate(format: "nom == %@", lastname)
        do{
            return try CoreDataManager.context.fetch(request) as [Membres]
        }
        catch{
            return nil
        } }
    
    static func count(forFirstname firstname: String, lastname: String) -> Int{
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@", firstname, lastname)
        
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(forFirstname firstname: String, lastname: String) -> [Membres]?{
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@", firstname, lastname)
        do{
            return try CoreDataManager.context.fetch(request) as [Membres]
        }
        catch{
            return nil
        } }
    
    
    
    static func search(forPerson membre: Membres) -> Membres?{
        self.request.predicate = NSPredicate(format: "prenom == %@ AND nom == %@", membre.nom!, membre.prenom!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Membres]
            guard result.count != 0 else { return nil }
            guard result.count == 1 else { fatalError("duplicate entries") }
            return result[0]
        }
        catch{
            return nil
        } }*/
}
