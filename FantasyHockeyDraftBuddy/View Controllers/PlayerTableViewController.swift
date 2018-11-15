//
//  PlayerTableViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-03.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class PlayerTableViewController: UIViewController, playerTableDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var sideMenuTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController:  nil)
    var players: [RosterElement] = []
    var filteredPlayers: [RosterElement] = []
    var menuVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        sideMenuTrailingConstraint.constant = 0 + self.sideMenuView.frame.size.width
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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

    @IBAction func exitButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindToLeagues", sender: self)
    }
    
    @objc func toggleSideMenu() {
        if menuVisible {
            UIView.animate(withDuration: 0.5) {
                self.sideMenuTrailingConstraint.constant = 0 + self.sideMenuView.frame.size.width
                self.tableViewLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
                }
        } else {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5) {
                self.sideMenuTrailingConstraint.constant = 0
                self.tableViewLeadingConstraint.constant = -self.sideMenuView.frame.size.width
                self.view.layoutIfNeeded()
            }
        }
        menuVisible = !menuVisible
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        toggleSideMenu()
    }
    
}
