//
//  PlayerTable+Searching.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-12.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

extension PlayerTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search Players"
        definesPresentationContext = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if(menuVisible) {
            toggleSideMenu()
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPlayers = players.filter({( player : RosterElement) -> Bool in
            return player.person.fullName.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}
