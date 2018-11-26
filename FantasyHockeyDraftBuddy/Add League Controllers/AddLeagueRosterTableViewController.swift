//
//  AddLeagueRosterTableViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-24.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class AddLeagueRosterTableViewController: UITableViewController, LeagueScoringCellDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var leagueName: String?
    var skaterStats: [(UserLeague.skaterStat, Double)]?
    var goalieStats: [(UserLeague.goalieStat, Double)]?
    
    let positions = UserLeague.Position.allValues
    var positionValues: [Int] = []
    
    var league: UserLeague?

    override func viewDidLoad() {
        super.viewDidLoad()

        positionValues = [Int](repeating: 0, count: positions.count)
        updateDoneButton()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return positions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addLeagueRosterCell", for: indexPath) as! AddLeagueScoringTableViewCell

        cell.delegate = self
        cell.setStepperProperties(minVal: 0, maxVal: 20, stepVal: 1)
        cell.update(statLabelText: positions[indexPath.row].rawValue, statCounter: Double(positionValues[indexPath.row]))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Roster Amounts"
    }
    
    func leagueScoringCellStepperChanged(sender: AddLeagueScoringTableViewCell, value: Double) {
        let indexPath = tableView.indexPath(for: sender)
        
        if let row = indexPath?.row {
            positionValues[row] = Int(value)
        }
        
        updateDoneButton()
    }
    
    func updateDoneButton() {
        if positionValues.filter( {$0 != 0} ).isEmpty {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToLeagues" {
            
            let positionArray = combineAndFilterArrays(keyArray: positions, valueArray: positionValues.map( {Double($0)} )) as! [(UserLeague.Position, Double)]
            
             league = UserLeague(name: leagueName!, positionSizes: positionArray, skaterStats: skaterStats!, goalieStats: goalieStats!, teams: [UserTeam(name: "Team", players: nil, keepers: nil)], playerList: nil)
            
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {

        
        performSegue(withIdentifier: "unwindToLeagues", sender: self)
    
    }
    
}
