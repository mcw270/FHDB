//
//  LoadingViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-04.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var players: [RosterElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
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
                self.performSegue(withIdentifier: "loadingSegue", sender: nil)
            }

    
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LeagueTableViewController
        destination.players = players        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
