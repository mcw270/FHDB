//
//  AddLeagueTeamTableViewCell.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-12-02.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

protocol AddTeamCellDelegate {
    func deleteButtonTouched(cell: AddLeagueTeamTableViewCell)
    func nameEditingChanged(cell: AddLeagueTeamTableViewCell, text: String?)
}

class AddLeagueTeamTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var teamNameTextField: UITextField!
    
    var delegate: AddTeamCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamNameTextField.autocorrectionType = .no
        teamNameTextField.autocapitalizationType = .words
        
        teamNameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func teamNameDeleteButtonTouched(_ sender: UIButton) {
        delegate?.deleteButtonTouched(cell: self)
    }
    
    @IBAction func teamNameEditingChanged(_ sender: UITextField) {
        delegate?.nameEditingChanged(cell: self, text: sender.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        teamNameTextField.resignFirstResponder()
        return true
    }
}
