//
//  ViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-29.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var players: [RosterElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PlayerTableViewController
        destination.players = players
    }
    
    @IBAction func tableButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showTableSegue", sender: nil)
    }
}

