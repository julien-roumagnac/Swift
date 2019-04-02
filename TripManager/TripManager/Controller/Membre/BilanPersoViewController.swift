//
//  BilanPersoViewController.swift
//  TripManager
//
//  Created by Audrey Samson on 02/04/2019.
//  Copyright © 2019 Julien Roumagnac. All rights reserved.
//

import Foundation
import UIKit

class BilanPersoViewController: UIViewController {
    var membre : Membres?
    
    @IBOutlet weak var nom : UILabel!
    @IBOutlet weak var depense : UILabel!
    @IBOutlet weak var messageDepart: UILabel!
    @IBOutlet weak var dateDepart: UILabel!
    
    @IBOutlet weak var container : UIView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        self.nom.text = (membre?.nom)! + "" + (membre?.prenom)!
        //self.prenom.text = membre?.prenom
        let depDouble : Double = membre?.dette ?? 0
        let depString : String = String(format:"%f", depDouble)
        self.depense.text = depString
        if membre?.dateDepart != nil {
            self.messageDepart.text = "Ce membre à quitter le voyage le :"
            self.dateDepart.text = membre?.dateDepart
        }
        else{
            self.messageDepart.text = ""
            self.dateDepart.text = ""
        }
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Depenses", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Dettes", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        self.updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
//            self.remove(asChildViewController: DetteViewController)
//            self.add(asChildViewController: DepenseViewController)
            container = DepenseViewController.view
        } else {
//            self.remove(asChildViewController: DepenseViewController)
//            self.add(asChildViewController: DetteViewController)
            container = DetteViewController.view
        }
    }
    func setupView() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private lazy var DepenseViewController: DepenseMembreViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "DepenseMembreViewController") as! DepenseMembreViewController
        
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        
        return viewController
    }()
    
    private lazy var DetteViewController: DetteMembreViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "DetteMembreViewController") as! DetteMembreViewController
        
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) != nil {
            if let departMembreController = segue.destination as? DepartMembreViewController {
                    departMembreController.membre = self.membre
                }
            }
    }
    
}
