//
//  PlayerTableViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-03.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController, playerTableDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    let searchController = UISearchController(searchResultsController:  nil)
    
    func starTapped(sender: PlayerTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let player = players[indexPath.row]
            player.person.isFavorited = !player.person.isFavorited
            players[indexPath.row] = player
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func playerTablePanGesture(offset: CGPoint) {
        for cell in tableView.visibleCells {
            let playerCell = cell as! PlayerTableViewCell
            playerCell.setScrollingOffsetAfterGesture(offset: offset)
        }
    }
    
    
    var players: [RosterElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = " "
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        navigationItem.titleView = searchController.searchBar
        
        
        definesPresentationContext = true
        
        setUpSearchBar()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setUpSearchBar() {
    // Set search bar position and dimensions
        let searchBarFrame: CGRect = searchController.searchBar.frame
        let viewFrame = view.frame
        searchController.searchBar.frame = CGRect(x: searchBarFrame.origin.x, y: searchBarFrame.origin.y + 64, width: viewFrame.size.width, height: 44)
        
        // Add search controller's search bar to our view and bring it to forefront
        view.addSubview(self.searchController.searchBar)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return players.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell

        cell.delegate = self
        let player = players[indexPath.row]
        cell.setPlayer(player)
        cell.starButton.isSelected = player.person.isFavorited
        cell.setOffset()
        cell.update()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Recommended Pick"
        } else {
            return "All Players"
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
