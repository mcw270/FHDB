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
    @IBOutlet weak var tableView: UITableView!
    
    var leagueName = ""
    var teams: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !areTeamsAdded() && !isLeagueNameFilledIn() {
            nextButton.isEnabled = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        leagueNameTextField.autocorrectionType = .no
        leagueNameTextField.autocapitalizationType = .words
    }
    
    func areTeamsAdded() -> Bool {
        if teams.count >= 2 {
            if teams[0] == "" || teams[1] == "" {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func isLeagueNameFilledIn() -> Bool {
        if leagueNameTextField.text == "" {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func leagueNameTextChanged(_ sender: Any) {
        if areTeamsAdded() && isLeagueNameFilledIn() {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "leagueNameToScoringSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddLeagueScoringTableViewController
        
        let filteredTeams = teams.filter( { $0 != "" })
        
        leagueName = leagueNameTextField.text!
        destination.leagueName = leagueName
        destination.teams = filteredTeams
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        teams.append("")
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: teams.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        let cell = tableView.cellForRow(at: IndexPath(row: teams.count - 1, section: 0)) as! AddLeagueTeamTableViewCell
        cell.teamNameTextField.becomeFirstResponder()
    }
}
