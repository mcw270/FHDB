//
//  ViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-29.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class LeagueTableViewController: UITableViewController {
    
    
    var leagues: [UserLeague] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

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
        
        if segue.identifier == "leagueSegue" {
            let barViewControllers = segue.destination as! UITabBarController
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.viewControllers[0] as! PlayerTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                if let playerList = leagues[indexPath.row].playerList {
                    destinationViewController.players = playerList
                }
            }
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

