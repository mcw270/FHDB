//
//  ViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-29.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class LeagueTableViewController: UITableViewController {
    
    var players: [RosterElement] = []
    var leagues: [UserLeague] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let alert = UIAlertController(title: "Loaded", message: "Loaded Data", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return leagues.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueTableViewCell
        
        let league = leagues[indexPath.row]
        cell.update(league: league)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "leagueSegue", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! PlayerTableViewController
//        destination.players = players
        
        if segue.identifier == "leagueSegue" {
            let barViewControllers = segue.destination as! UITabBarController
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.viewControllers[0] as! PlayerTableViewController
            destinationViewController.players = players
        }
    }
    
    @IBAction func unwindToLeagues(segue:UIStoryboardSegue) {
        
        guard segue.identifier == "unwindToLeagues" else { return }
        
        let sourceVC = segue.source as! AddLeagueRosterTableViewController
        
        if let league = sourceVC.league {
            let newIndexPath = IndexPath(row: leagues.count, section: 0)
            leagues.append(league)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
}

