//
//  AddLeagueScoringTableViewController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-24.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit
import Foundation

class AddLeagueScoringTableViewController: UITableViewController, LeagueScoringCellDelegate {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    var leagueName: String?
    
    let skaterScoringStats = UserLeague.skaterStat.allValues
    let goalieScoringStats = UserLeague.goalieStat.allValues
    
    var skaterScoringStatsValues: [Double] = []
    var goalieScoringStatsValues: [Double] = []
    
    var skaterScoringArray: [(UserLeague.skaterStat, Double)] = []
    var goalieScoringArray: [(UserLeague.goalieStat, Double)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        skaterScoringStatsValues = [Double](repeating: 0.0, count: skaterScoringStats.count)
        goalieScoringStatsValues = [Double](repeating: 0.0, count: goalieScoringStats.count)
        
        updateNextButton()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return skaterScoringStats.count
        } else if section == 1 {
            return goalieScoringStats.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addLeagueScoringCell", for: indexPath) as! AddLeagueScoringTableViewCell
        cell.delegate = self
        cell.setStepperProperties(minVal: -20, maxVal: 20, stepVal: 0.5)
        if indexPath.section == 0 {
            cell.update(statLabelText: skaterScoringStats[indexPath.row].rawValue, statCounter: skaterScoringStatsValues[indexPath.row])
        } else if indexPath.section == 1 {
            cell.update(statLabelText: goalieScoringStats[indexPath.row].rawValue, statCounter: goalieScoringStatsValues[indexPath.row])
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Skater Stat Categories"
        } else if section == 1 {
            return "Goalie Stat Categories"
        }
        return ""
    }
    
    func leagueScoringCellStepperChanged(sender: AddLeagueScoringTableViewCell, value: Double) {
        let indexPath = tableView.indexPath(for: sender)
        
        if indexPath?.section == 0 {
            if let row = indexPath?.row {
                skaterScoringStatsValues[row] = value
            }
        } else if indexPath?.section == 1 {
            if let row = indexPath?.row {
                goalieScoringStatsValues[row] = value
            }
        }
        updateNextButton()
    }
    
    func updateNextButton() {
        if skaterScoringStatsValues.filter( {$0 != 0} ).isEmpty && goalieScoringStatsValues.filter( {$0 != 0} ).isEmpty {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scoringToRosterSegue" {
            skaterScoringArray = combineAndFilterArrays(keyArray: skaterScoringStats, valueArray: skaterScoringStatsValues) as! [(UserLeague.skaterStat, Double)]
            goalieScoringArray = combineAndFilterArrays(keyArray: goalieScoringStats, valueArray: goalieScoringStatsValues) as! [(UserLeague.goalieStat, Double)]
            let destination = segue.destination as! AddLeagueRosterTableViewController
            destination.leagueName = leagueName
            destination.skaterStats = skaterScoringArray
            destination.goalieStats = goalieScoringArray
        }
    }
}
