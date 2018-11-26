//
//  AddLeagueScoringTableViewCell.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-24.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

protocol LeagueScoringCellDelegate {
    func leagueScoringCellStepperChanged(sender: AddLeagueScoringTableViewCell, value: Double)
}

class AddLeagueScoringTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statLabel: UILabel!
    @IBOutlet weak var statCountLabel: UILabel!
    @IBOutlet weak var statStepper: UIStepper!
    
    var delegate: LeagueScoringCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setStepperProperties(minVal: Double, maxVal: Double, stepVal: Double) {
        statStepper.minimumValue = minVal
        statStepper.maximumValue = maxVal
        statStepper.stepValue = stepVal
    }

    func update(statLabelText: String, statCounter: Double) {
        statLabel.text = statLabelText
        statCountLabel.text = String(statCounter)
        statStepper.value = statCounter
    }

    @IBAction func stepperTapped(_ sender: UIStepper) {
        statCountLabel.text = String(sender.value)
        delegate?.leagueScoringCellStepperChanged(sender: self, value: sender.value)
    }
}
