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
    
    public var dateArriveM : String? {
        get { return self.dateArrivee }
        set { self.dateArrivee = dateArriveM }
    }
    
    public var dateDepartM : String? {
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
        self.dateArrivee = Date().description
    }
    
    /*
     /// initialize a `Membre`
     ///
     /// - Parameters:
     ///   - firstname: `String` first name of `Person`
     ///   - lastname:  `String` last name of `Person`
     ///   - birthdate: `Date` birth date pf `Person`
     convenience init(firstname: String, lastname: String, birthdate: Date){
     self.init(context: CoreDataManager.context)
     self.pfirstname = firstname
     self.plastname  = lastname
     self.pbirthdate = birthdate
     }
     /// initialize a `Person`
     ///
     /// - Parameters:
     ///   - firstname: `String` first name of `Person`
     ///   - lastname:  `String` last name of `Person`
     ///   - birthdate: `Date` birth date pf `Person`
     convenience init(firstname: String, lastname: String, birthdate: Date, city: String?, country: String?){
     self.init(context: CoreDataManager.context)
     self.pfirstname = firstname
     self.plastname  = lastname
     self.pbirthdate = birthdate
     if (city==nil) && (country==nil){
     self.inhabit = nil
     } else{
     if let town = TownDAO.search(forCity: city, andCountry: country){
     self.inhabit = town
     } else{
     self.inhabit = Town(context: CoreDataManager.context)
     self.inhabit?.pcity    = city
     self.inhabit?.pcountry = country
     } }
     } */}

