//
//  NHLRoster.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-31.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import Foundation

struct NHLTeamRoster: Codable {
    let rosterList: [RosterElement]
    
    enum CodingKeys: String, CodingKey {
        case rosterList = "roster"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.rosterList = try valueContainer.decode([RosterElement].self, forKey: CodingKeys.rosterList)
    }

}

class RosterElement: Codable {
    let person: NHLPlayer
    let jerseyNumber: String?
    let position: Position
    var stats: SplitStat? = nil
    
    enum CodingKeys: String, CodingKey {
        case person, jerseyNumber, position
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.person = try valueContainer.decode(NHLPlayer.self, forKey: CodingKeys.person)
        self.jerseyNumber = try? valueContainer.decode(String.self, forKey: CodingKeys.jerseyNumber)
        self.position = try valueContainer.decode(Position.self, forKey: CodingKeys.position)
    }
    
    func setStats(stats: SplitStat) {
//        APIController.fetchStatistics(playerID: id, completion: { (statistics) in
//            self.stats = statistics
//        })
        self.stats = stats
    }
}

struct Position: Codable {
    let name: PositionName
    let type: TypeEnum
    let abbreviation: PositionAbbreviation
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try valueContainer.decode(PositionName.self, forKey: CodingKeys.name)
        self.type = try valueContainer.decode(TypeEnum.self, forKey: CodingKeys.type)
        self.abbreviation = try valueContainer.decode(PositionAbbreviation.self, forKey: CodingKeys.abbreviation)
    }
}

enum PositionName: String, Codable {
    case center = "Center"
    case defenseman = "Defenseman"
    case goalie = "Goalie"
    case leftWing = "Left Wing"
    case rightWing = "Right Wing"
}


enum PositionAbbreviation: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case lw = "LW"
    case rw = "RW"
}

enum TypeEnum: String, Codable {
    case defenseman = "Defenseman"
    case forward = "Forward"
    case goalie = "Goalie"
}
