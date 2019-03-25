//
//  NewVoyageViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 24/03/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewVoyageViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var membres: [Membres] = []
    
    @IBOutlet weak var nomNewVoyage: UITextField!
    @IBOutlet weak var photoNewVoyage: UIImageView!
    @IBOutlet weak var nomNewMembre: UITextField!
    @IBOutlet weak var prenomNewMembre: UITextField!
    @IBOutlet weak var dateANewMembre: UIDatePicker!
    @IBOutlet weak var tableMembres: UITableView!
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: self.tableMembres)
        let indexPath = self.tableMembres.indexPathForRow(at: buttonPosition)
        self.deleteNewMembre(at: indexPath!.row)
        tableMembres.reloadData()
    }
    
    @IBAction func ajoutAction(_ sender: Any) {
        self.newMembre(nom: self.nomNewMembre.text ?? "", prenom: self.prenomNewMembre.text ?? "")
        tableMembres.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okAction(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.membres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membreCell", for: indexPath) as! MembreTableViewCell
        cell.nomMembre.text = self.membres[indexPath.row].nom
        cell.prenomMembre.text = self.membres[indexPath.row].prenom
        return cell
    }
    
    func newMembre(nom: String, prenom: String){
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        let m = Membres(context: context)
        m.nom = nom
        m.prenom = prenom
        self.membres.append(m)
        self.nomNewMembre.text = ""
        self.prenomNewMembre.text = ""
    }
    
    func deleteNewMembre(at: Int){
        let m = membres[at]
        self.membres.remove(at: at)
        guard let appD = UIApplication.shared.delegate as? AppDelegate else{
            print("error")
            return
        }
        let context = appD.persistentContainer.viewContext
        context.delete(m)
        
    }
}
