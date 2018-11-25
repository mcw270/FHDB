//
//  LeagueNameViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-24.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class LeagueNameViewController: UIViewController {
    
    @IBOutlet weak var leagueNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    var leagueName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if leagueNameTextField.text == "" {
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func leagueNameTextChanged(_ sender: Any) {
        if leagueNameTextField.text == "" {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        leagueName = leagueNameTextField.text!
        performSegue(withIdentifier: "leagueNameToScoringSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddLeagueScoringTableViewController
        
        destination.leagueName = leagueName
    }

}
