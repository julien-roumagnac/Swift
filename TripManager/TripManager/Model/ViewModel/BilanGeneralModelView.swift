//
//  BilanGeneralViewModel.swift
//  TripManager
//
//  Created by Julien Roumagnac on 26/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BilanGeneralViewModel {
    
    var bilan: [Dette] = []
    var maxDette : Double = 0
    
    
    init(membres: [Membres]){
        
        self.bilan = equilibre(membres: membres)
        for dette in bilan {
            dette.creancié.dette -= dette.montant
            dette.endetté.dette += dette.montant
            
        }
        
        maxDette = self.getMaxDette()
    }
    
    
    func equilibre(membres : [Membres] ) -> [Dette]{
        
        
        var creanciés : [Membres] = [] //membres ayant une dette negative ( on leur doit de l'argent)
        var endettés : [Membres] = [] // membres ayant une dette positive ( ils doivent de l'argent)
        var hasBonCreancié, hasParfaitCreancié : Bool // variable pour savoir si letape 2a ete concluante ou non et donc si on doit faire l'etape 3 ou pas
        var dettes: [Dette] = []
        
        for membre in membres {  // on remplit creanciés et endettés avec les membres pour les separer
            if(membre.dette > 0){
                endettés.append(membre)
                
            }else {
                creanciés.append(membre)
            }
        }
        // boucle de remplissage des dettes calculés on continue tant quil y a des personnes dans le tableau des endettés
        var i : Int = 0
        while endettés.count > 0 {
            i = i + 1
            
            
            hasBonCreancié = false
            hasParfaitCreancié = false
            
            // Etape 1 : on cherche tout les creanciers et endettés ayant une ette identique pour les mettres ensemble
            (creanciés,endettés,dettes,hasParfaitCreancié) = chercherPaireParfaite(cr : creanciés, en : endettés, d : dettes , hasPC : hasParfaitCreancié)
            
            
            // Etape 2 : On cherche mainteant si y a des creanciers pouvant couvrir toute la dette d'un endetté si c'est le cas on les mets ensemble et on decremente la creance du creancié et la dette  de l'endetté est a 0. Si on trouve une paire le boolean HasBonCreancier devient TRUE,puis on retourne a l'etape 1 car des paireParfaite aurait pu se creer grace aux changement de la valeur de la creance du créancié.
            
            if(!hasParfaitCreancié){
                (creanciés,endettés,dettes,hasBonCreancié) = chercherPaireMoyenne(cr : creanciés, en : endettés, d : dettes, hasBC : hasBonCreancié)
            }
            
            // Etape 3 : On ne realise cette etape que si on a pas trouvé de paire lors de l'etape 2. Cela veux dire qu'il n'y a que des endettés dont la dette est superieur aux creances des creanciés. On va donc chercher le plus grand creancié et laffecter avec un endetté. On enleve le creancie choisi car il naura plus de creance et on modifie la dette de l'endetté qui baisse. puis on retourne a l'etape 1 car des paireParfaite aurait pu se creer grace aux changement de la valeur de la dette de l'endetté.
            if(!hasBonCreancié && !hasParfaitCreancié){
                (creanciés,endettés,dettes) =  chercherPaireNulle(cr: creanciés, en: endettés, d: dettes)
                
            }
            
        }
        return dettes
        
        
        
        
        
    }
    
    
    func chercherPaireParfaite( cr : [Membres], en : [Membres], d : [Dette] , hasPC : Bool) -> ( [Membres],[Membres],[Dette],Bool){
        var d2 = d
        var cr2 = cr
        var en2 = en
        var h = hasPC
        var j : Int = 0
        var i : Int = 0
        // on copie les entrees car on ne peux pas les modifier vu quelles sont en aprametres sont consideres comme constante on renvoi ces copies a la fin
        
        while (!h) && (i < en2.count) // on regarde si on a pas deja trouve une dette possible ou si on est arrivé au bout des endettés
        {
            
            j = 0
            while (j < cr2.count) && (!h)
            {
                
                if(en2[i].dette == -cr2[j].dette) {
                    h = true
                    
                    d2.append(Dette(p1: en2[i], montant: en2[i].dette , p2: cr2[j]))
                    
                    cr2[j].dette = 0
                    en2[i].dette = 0
                    en2.remove(at: i )
                    cr2.remove(at: j)
                    
                    
                }
                
                j = j+1
            }
            i = i+1
        }
        
        return (cr2,en2,d2,h)
        
    }
    func chercherPaireMoyenne( cr : [Membres], en : [Membres], d : [Dette], hasBC : Bool)-> ( [Membres],[Membres],[Dette],Bool){
        var cr2 = cr
        var en2 = en
        var d2 = d
        var h = hasBC
        var i : Int = 0
        var j : Int
        
        while (!h) && (i < en2.count) // on regarde si on a pas deja trouve une dette possible ou si on est arrivé au bout des endettés
        {
            j = 0
            while (j < cr2.count) && (!h)
            {
                if(en2[i].dette < -cr2[j].dette) {
                    h = true
                    cr2[j].dette = cr2[j].dette + en2[i].dette
                    d2.append(Dette(p1: en2[i], montant: en2[i].dette , p2: cr2[j]))
                    en2[i].dette = 0
                    en2.remove(at: i )
                    
                }
                
                j = j+1
            }
            i = i+1
        }
        
        
        return (cr2,en2,d2,h)
        
    }
    func chercherPaireNulle( cr : [Membres], en : [Membres], d : [Dette]) -> ( [Membres],[Membres],[Dette]){
        var max : Double = 0
        var PGC : Int = 0
        var cr2 = cr
        var en2 = en
        var d2 = d
        
        for i in 0..<cr2.count {
            if (cr2[i].dette < max){ // signe < car les cr2.dettes sont negatives
                max = cr2[i].dette
                PGC = i
            }
            
            
        }
        
        en2[0].dette = en2[0].dette + cr2[PGC].dette
        d2.append(Dette(p1: en2[0], montant: -cr2[PGC].dette ,p2 : cr2[PGC]))
        cr2[PGC].dette = 0
        cr2.remove(at: PGC)
        return (cr2,en2,d2)
    }
    func getMaxDette() -> Double {
        var res : Double = 0
        for dette in bilan {
            if abs(dette.montant) > res {
                res = dette.montant
            }
        }
        return res
    }
}



class Dette {
    var endetté : Membres
    var creancié : Membres
    var montant : Double
    
    init(p1 : Membres,montant : Double, p2 : Membres){
        self.endetté = p1
        self.creancié = p2
        self.montant = montant
        
    }
    
    public func toString() -> String{
        var res : String = ""
        res =  self.endetté.nom! + " doit " + self.montant.description + " à " + self.creancié.nom!
        
        return res
    }
 
    
    
}

