//
//  MembreCoreData.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
/*
 // MARK: -
 Membres type
 **nom**: Membre -> String
 **prenom**: Membre -> String
 **nomcomplet**: Membre -> String
 **dette**: Membre -> Double?
 **dateDepart**: Membre -> String?
 **dateArrivee**: Membre -> String?
 */
extension Membres{
    // MARK: -
    /// firstname of Person
    public var prenomM : String { return self.prenom ?? "" }
    /// lastname of Person
    public var nomM  : String { return self.nom  ?? "" }
    
    /// fullname property: `String` firstname lastname (read-only)
    public var nomCompletM: String {
        return self.prenom! + " " + self.nom!
    }
    
    public var destinationM : String?{
        get{ return self.destination?.nom }
        /*set{
         if let voyage = self.destination{
         
         } else{
         self.destination = Voyage(context: CoreDataManager.context)
         }
         }*/ }
    
    public var detteM : Double{
        get { return self.dette }
        set { self.dette = detteM}
    }
    
    public var dateArriveM : Date? {
        get { return self.dateArrivee }
        set { self.dateArrivee = dateArriveM }
    }
    
    public var dateDepartM : Date? {
        get { return self.dateDepart }
        set { self.dateDepart = dateDepartM }
    }
    
    
    /// initialize a `Membre`
    ///
    /// - Parameters:
    ///   - prenom: `String` first name of `Membre`
    ///   - nom:  `String` last name of `Membre`
    ///   - dette:  `Double` liability of `Membre`
    ///   - dateArrivee:  `String` arrival date of `Membre`
    ///   - dateDepart:  `String` departure date of `Membre`
    convenience init(prenomM: String, nomM: String){
        self.init(context: CoreDataManager.context)
        self.prenom = prenomM
        self.nom  = nomM
        self.dette = 0
        self.dateDepart = nil
        self.dateArrivee = Date()
    }
    
   }

