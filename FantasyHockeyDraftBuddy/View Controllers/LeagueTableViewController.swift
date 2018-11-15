//
//  ViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-29.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class LeagueTableViewController: UIViewController {
    
    var players: [RosterElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! PlayerTableViewController
//        destination.players = players
        
        
        let barViewControllers = segue.destination as! UITabBarController
        let nav = barViewControllers.viewControllers![0] as! UINavigationController
        let destinationViewController = nav.viewControllers[0] as! PlayerTableViewController
        destinationViewController.players = players
    }
    
    @IBAction func tableButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showTableSegue", sender: nil)
        
        
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

}

