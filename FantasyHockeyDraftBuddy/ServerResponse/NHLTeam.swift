
//  NHLTeams.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-31.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.


import Foundation

struct Teams: Codable {
    let teamList: [NHLTeam]
    
    enum CodingKeys: String, CodingKey {
        case teamList = "teams"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.teamList = try valueContainer.decode([NHLTeam].self, forKey: CodingKeys.teamList)
    }
}

class NHLTeam: Codable {
    let id: Int
    let name: String
    let abbreviation, teamName: String
    let roster: NHLTeamRoster
    
    required init(from decoder: Decoder) throws {
        
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.abbreviation = try valueContainer.decode(String.self, forKey: CodingKeys.abbreviation)
        self.teamName = try valueContainer.decode(String.self, forKey: CodingKeys.teamName)
        self.roster = try valueContainer.decode(NHLTeamRoster.self, forKey: CodingKeys.roster)
        
    }
}
