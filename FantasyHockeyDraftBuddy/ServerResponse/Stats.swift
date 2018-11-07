//
//  Stats.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-02.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import Foundation

class Stats: Codable {
    let statElementList: [StatElement]
    
    enum CodingKeys: String, CodingKey {
        case statElementList = "stats"
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.statElementList = try valueContainer.decode([StatElement].self, forKey: CodingKeys.statElementList)
    }
    // Test Commit
    struct StatElement: Codable {
        let statList: [Split]
        
        enum CodingKeys: String, CodingKey {
            case statList = "splits"
        }
        
        init(from decoder: Decoder) throws {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.statList = try valueContainer.decode([Split].self, forKey: CodingKeys.statList)
        }
    }
    
    struct Split: Codable {
        let stat: SplitStat
        
        init(from decoder: Decoder) throws {
            let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.stat = try valueContainer.decode(SplitStat.self, forKey: CodingKeys.stat)
        }
    }
    
}

struct SplitStat: Codable {
    let timeOnIce: String //
    
    let assists, goals, pim, shots: Int?
    
    let games: Int //
    
    let hits, powerPlayGoals, powerPlayPoints: Int?
    let powerPlayTimeOnIce, evenTimeOnIce, penaltyMinutes: String?
    let faceOffPct, shotPct: Double?
    let gameWinningGoals, overTimeGoals, shortHandedGoals, shortHandedPoints: Int?
    let shortHandedTimeOnIce: String?
    let blocked, plusMinus, points, shifts: Int?
    
    let timeOnIcePerGame: String //
    
    let evenTimeOnIcePerGame, shortHandedTimeOnIcePerGame, powerPlayTimeOnIcePerGame: String?
    
    let ot, shutouts, ties, wins: Int?
    let losses, saves, powerPlaySaves, shortHandedSaves: Int?
    let evenSaves, shortHandedShots, evenShots, powerPlayShots: Int?
    let savePercentage, goalAgainstAverage: Double?
    let gamesStarted, shotsAgainst, goalsAgainst: Int?
    let powerPlaySavePercentage, shortHandedSavePercentage, evenStrengthSavePercentage: Double?
}

