//
//  PlayerTableViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-03.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController, playerTableDelegate {
    
    let searchController = UISearchController(searchResultsController:  nil)
    var players: [RosterElement] = []
    var filteredPlayers: [RosterElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isFiltering() {
                return 0
            } else {
                return 1
            }
        } else if section == 1 {
            if isFiltering() {
                return filteredPlayers.count
            }
            return players.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell

        cell.delegate = self
        let player: RosterElement
        
        if indexPath.section == 0 {
            player = players[indexPath.row]
            cell.setOffset(offset: nil)
        } else {
            if isFiltering() {
                player = filteredPlayers[indexPath.row]
                cell.setOffset(offset: CGPoint.zero)
            } else {
                player = players[indexPath.row]
                cell.setOffset(offset: nil)
            }
        }
        
        cell.setPlayer(player)
        cell.starButton.isSelected = player.person.isFavorited
        cell.update()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if isFiltering() {
                return nil
            } else {
                return "Recommended Pick"
            }
        } else {
            return "All Players"
        }
    }
    
    func starTapped(sender: PlayerTableViewCell) {
        let player: RosterElement
        if let indexPath = tableView.indexPath(for: sender) {
            if isFiltering() {
                player = filteredPlayers[indexPath.row]
                player.person.isFavorited = !player.person.isFavorited
                filteredPlayers[indexPath.row] = player
            } else {
                player = players[indexPath.row]
                player.person.isFavorited = !player.person.isFavorited
                players[indexPath.row] = player
            }
            
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.reloadSections([0], with: .none)
        }
    }
    
    func playerTablePanGesture(offset: CGPoint) {
        for cell in tableView.visibleCells {
            let playerCell = cell as! PlayerTableViewCell
            playerCell.setScrollingOffsetAfterGesture(offset: offset)
        }
    }

}
