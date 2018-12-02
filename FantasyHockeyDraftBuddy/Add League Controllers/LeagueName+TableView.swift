//
//  LeagueName+TableView.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-12-01.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

extension LeagueNameViewController: UITableViewDelegate, UITableViewDataSource, AddTeamCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teams.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! AddLeagueTeamTableViewCell
            cell.delegate = self
            cell.teamNameTextField.text = teams[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell")!
            cell.selectionStyle = .none
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        
    func deleteButtonTouched(cell: AddLeagueTeamTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        teams.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        if areTeamsAdded() && isLeagueNameFilledIn() {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func nameEditingChanged(cell: AddLeagueTeamTableViewCell, text: String?) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        
        if let text = text {
            teams[indexPath.row] = text
        }
        
        if areTeamsAdded() && isLeagueNameFilledIn() {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    
}
