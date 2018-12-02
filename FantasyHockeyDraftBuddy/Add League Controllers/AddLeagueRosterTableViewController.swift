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
    var teams: [String]?
    var skaterStats: [(UserLeague.skaterStat, Double)]?
    var goalieStats: [(UserLeague.goalieStat, Double)]?
    var players: [RosterElement] = []
    
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
            
            var allTeams: [UserTeam] = []
            let positionArray = combineAndFilterArrays(keyArray: positions, valueArray: positionValues.map( {Double($0)} )) as! [(UserLeague.Position, Double)]
            
            if let teams = teams {
                for team in teams {
                    let userTeam = UserTeam(name: team, players: nil, keepers: nil)
                    allTeams.append(userTeam)
                }
            }
            
             league = UserLeague(name: leagueName!, positionSizes: positionArray, skaterStats: skaterStats!, goalieStats: goalieStats!, teams: allTeams, playerList: players)
            
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        
        let group = DispatchGroup()
        APIController.fetchNHLInfo { (teamList) in
            for team in teamList {
                for player in team.roster.rosterList {
                    group.enter()
                    player.person.team = team.abbreviation
                    self.players.append(player)
                    APIController.fetchStatistics(playerID: player.person.id, completion: { (stats) in
                        guard let stats = stats else {
                            group.leave()
                            return
                        }
                        
                        player.setStats(stats: stats)
                        group.leave()
                    })
                }
            }
            
            group.notify(queue: .main) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "unwindToLeagues", sender: self)
                }
            }
        }
    }
    
}
