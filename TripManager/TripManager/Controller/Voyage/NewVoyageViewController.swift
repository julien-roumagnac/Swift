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
    @IBOutlet weak var dateVoyage: UIDatePicker!
    
    @IBAction func saveAction(_ sender: Any) {
        let nom : String = nomNewVoyage.text ?? ""
        guard (nom != "") else {return }
        let context = CoreDataManager.context
        let voyage = Voyage(context: context)
        voyage.nom = nom
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd/yyyy"
        let date : String = dateFormatterPrint.string(from: self.dateVoyage.date)
        voyage.dateDebut = date
        voyage.photo = (self.photoNewVoyage.image ?? UIImage(named: "placeholder")!).pngData()
        for membre in membres {
            voyage.addToVoyageurs(membre)
            membre.destination = voyage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: self.tableMembres)
        let indexPath = self.tableMembres.indexPathForRow(at: buttonPosition)
        self.deleteNewMembre(at: indexPath!.row)
        tableMembres.reloadData()
    }
    
    @IBAction func ajoutAction(_ sender: Any) {
        if((self.nomNewMembre.text?.isEmpty)! || (self.prenomNewMembre.text?.isEmpty)!) {
            return
        }
        else{
            self.newMembre(nom: self.nomNewMembre.text ?? "", prenom: self.prenomNewMembre.text ?? "",date: self.dateANewMembre.date)
            tableMembres.reloadData()
        }
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.membres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membreCell", for: indexPath) as! MembreTableViewCell
        cell.nomMembre.text = self.membres[indexPath.row].nom
        cell.prenomMembre.text = self.membres[indexPath.row].prenom
        return cell
    }
    
    func newMembre(nom: String, prenom: String, date: Date){
        let context = CoreDataManager.context
        let m = Membres(context: context)
        m.nom = nom
        m.prenom = prenom
        m.dateArrivee = date
        self.membres.append(m)
        self.nomNewMembre.text = ""
        self.prenomNewMembre.text = ""
    }
    
    func deleteNewMembre(at: Int){
        let m = membres[at]
        self.membres.remove(at: at)
        CoreDataManager.context.delete(m)
    }
    //MARK - Photo Manager
    
    @IBAction func displayActionSheet(_ sender: Any) {
        let alert = UIAlertController(title: "Update your photo", message: "Please select an option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take a new photo", style: .default , handler:{ (UIAlertAction)in
            self.presentUIImagePicker(sourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default , handler:{ (UIAlertAction)in
            self.presentUIImagePicker(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    private func presentUIImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true, completion: nil)
    }
    
    
}
extension NewVoyageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) -> UIImage {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return UIImage(named: "placeholder")!
        }
        dismiss(animated: true, completion: nil)
        self.photoNewVoyage.image = chosenImage
        return chosenImage
}
}


