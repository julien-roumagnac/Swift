//
//  VoyageCoreData.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
/*
 // MARK: -
 Voyage type
 **nom**: Voyage -> String
 **dateDebut**: Voyage -> String
 **dateFin**: Voyage -> String?
 **photo**: Voyage -> Image?
 */
extension Voyage{
    // MARK: -
    /// firstname of Voyage
    public var nomV : String { return self.nom ?? "" }
    /// photo of Voyage
    /*public var photoV  : IMAGE? {
        get { return self.photo  ?? "" }
        set { self.photo = photoV }
    }*/
    /// date of Voyage
    public var dateDebutV  : String { return self.dateDebut  ?? "" }
    /// departure date of Voyage
    public var dateFinV  : String? {
        get { return self.dateFin  ?? "" }
        set { self.dateFin = dateFinV }
    }
    
    /// initialize a `Voyage`
    ///
    /// - Parameters:
    ///   - nom:  `String` name of `Voyage`
    ///   - photo:  `Image` photo of `Voyage`
    ///   - dateDebut:  `String` date of `Voyage`
    ///   - dateFin:  `String` departure date of `Voyage`
    convenience init(nomV: String, dateDebutV: String){
        self.init(context: CoreDataManager.context)
        self.nom = nomV
        self.dateDebut = dateDebutV
        self.dateFin = nil
        self.photo = nil
    }
    
    /// initialize a `Voyage`
    ///
    /// - Parameters:
    ///   - nom:  `String` name of `Voyage`
    ///   - photo:  `Image` photo of `Voyage`
    ///   - dateDebut:  `String` date of `Voyage`
    ///   - dateFin:  `String` departure date of `Voyage`
    /*convenience init(nomV: String, dateDebutV: String, photoV : Image){
        self.init(context: CoreDataManager.context)
        self.nom = nomV
        self.dateDebut = dateDebutV
        self.dateFin = nil
        self.photo = photoV
    }*/

}
