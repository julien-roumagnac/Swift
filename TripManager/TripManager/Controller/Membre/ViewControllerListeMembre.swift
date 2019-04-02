//
//  ViewControllerListeMembre.swift
//  TripManager
//
//  Created by Audrey Samson on 01/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerListeMembre : UIViewController, UITextFieldDelegate {
    var voyage : Voyage?

    var tableViewController: MembreTableViewController!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nomNewMembre: UITextField!
    @IBOutlet weak var prenomNewMembre: UITextField!
    @IBOutlet weak var dateArriveeNewMembre: UIDatePicker!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = MembreTableViewController(tableView: self.tableView, voyage: voyage!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func deleteMAction(_ sender: UIButton) {
//        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: self.tableMembres)
//        let indexPath = self.tableMembres.indexPathForRow(at: buttonPosition)
//        self.deleteNewMembre(at: indexPath!.row)
//        tableMembres.reloadData()
//    }
//
    @IBAction func ajoutMAction(_ sender: Any) {
        if(self.nomNewMembre == nil || self.prenomNewMembre == nil) {
            return
        }
        else {
            self.ajoutMembre()
            self.tableViewController.dataSetChanged()
            do{
                try self.tableViewController.fetchResultController.membreFetched.performFetch()
            }
            catch let error as NSError{
                print("error")
            }
        }
    }
    
    func ajoutMembre(){
        let context = CoreDataManager.context
        let newMembre = Membres(context: context)
        newMembre.nom = self.nomNewMembre.text
        newMembre.prenom = self.prenomNewMembre.text
        newMembre.dateArrivee = self.dateArriveeNewMembre.date.description
        newMembre.dateDepart = nil
        newMembre.destination = voyage
        self.nomNewMembre.text = ""
        self.prenomNewMembre.text = ""
        do{
            try context.save()
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let m = self.tableViewController.fetchResultController.membreFetched
        if (sender as? MembrePresenterCell) != nil {
            if let detailMembreController = segue.destination as? BilanPersoViewController {
                if let index = self.tableView.indexPathForSelectedRow{
                    detailMembreController.membre = m.object(at: index)
                    self.tableView.deselectRow(at: index, animated: true)
                }
            }
        }
    }
    
    
    
   /* @IBAction func addAction(_ sender: Any) {
        let cf: Membres
        let df = DateFormatter()
        df.dateFormat = "dd-mm-yyyy"
        if let bdate = df.date(from: "01-06-1988"){
            //cf = Person(firstname: "Christophe", lastname: "Fiorio", birthdate: bdate)
        }
        else{
            cf = Person(firstname: "Christophe", lastname: "Fiorio", birthdate: Date())
        }
        self.tableViewController.personsViewModel.add(person: cf)
        //self.tableView.reloadData()
    }
    @IBAction func updateAction(_ sender: Any) {
        guard let index = self.tableView.indexPathForSelectedRow else{
            return
        }
        self.tableViewController.personsViewModel.updateBirthDate(atIndexPath: index, withDate: Date())
    }*/
}
