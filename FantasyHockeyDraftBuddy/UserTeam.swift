//
//  UserTeam.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-17.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import Foundation

class UserTeam {
    var name: String
    var players, keepers: [RosterElement]?
    
    init(name: String, players: [RosterElement]?, keepers: [RosterElement]?) {
        self.name = name
        self.players = players
        self.keepers = keepers
    }
}
