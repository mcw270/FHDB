//
//  UserLeague.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-17.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import Foundation

class UserLeague {
    var name: String
    var positionSizes: [(Position, Double)]
    var skaterStats: [(skaterStat, Double)]
    var goalieStats: [(goalieStat, Double)]
    var teams: [UserTeam]
    var playerList: [RosterElement]?
    var remainingRoster: [Position: Double] = [:]
    
    init(name: String, positionSizes: [(Position, Double)], skaterStats: [(skaterStat, Double)], goalieStats: [(goalieStat, Double)], teams: [UserTeam], playerList: [RosterElement]?) {
        self.name = name
        self.positionSizes = positionSizes
        self.skaterStats = skaterStats
        self.goalieStats = goalieStats
        self.teams = teams
        self.playerList = playerList
        
        positionSizes.forEach {
            self.remainingRoster[$0.0] = $0.1
        }
    }
    
    func draftPlayer(currentTeam: UserTeam, player: RosterElement, position: Position, selectedIndex: Int) {
        currentTeam.players?.append(player)
        playerList?.remove(at: selectedIndex)
        
        if let currPositionAmount = remainingRoster[position] {
            remainingRoster[position] = currPositionAmount - 1
        }
    }
    
    func getRecommendedPlayer() {
        
    }
    
    enum Position: String {
        case forward = "Forward"
        case leftWing = "Left Wing"
        case center = "Center"
        case rightWing = "Right Wing"
        case defenseman = "Defenseman"
        case goalie = "Goalie"
        case bench = "Bench"
        
        static let allValues = [forward,
                                leftWing,
                                center,
                                rightWing,
                                defenseman,
                                goalie,
                                bench]
        
        var abbreviation: String {
            switch self {
            case .forward: return "F"
            case .leftWing: return "LW"
            case .center: return "C"
            case .rightWing: return "RW"
            case .defenseman: return "D"
            case .goalie: return "G"
            case .bench: return "BN"
            }
        }
    }
    
    enum skaterStat: String {
        case fantastPoints          =       "Fantasy Points"
        case games                  =       "Games Played"
        case goals                  =       "Goals"
        case assists                =       "Assists"
        case points                 =       "Points"
        case pim                    =       "Penalty Minutes"
        case shots                  =       "Shots on Goal"
        case hits                   =       "Hits"
        case powerPlayGoals         =       "Powerplay Goals"
        case powerPlayPoints        =       "Powerplay Points"
        case gameWinningGoals       =       "Game Winning Goals"
        case overTimeGoals          =       "Overtime Goals"
        case shortHandedGoals       =       "Shorthanded Goals"
        case shortHandedPoints      =       "Shorthanded Points"
        case blocked                =       "Blocks"
        case plusMinus              =       "Plus Minus"
        
        static let allValues = [games,
                                goals,
                                assists,
                                points,
                                pim,
                                shots,
                                hits,
                                powerPlayGoals,
                                powerPlayPoints,
                                gameWinningGoals,
                                overTimeGoals,
                                shortHandedGoals,
                                shortHandedPoints,
                                blocked,
                                plusMinus]
        
        var abbreviation: String {
            switch self {
            case .fantastPoints:            return "FANP"
            case .games:                    return "GP"
            case .goals:                    return "G"
            case .assists:                  return "A"
            case .points:                   return "P"
            case .pim:                      return "PIM"
            case .shots:                    return "SOG"
            case .hits:                     return "HITS"
            case .powerPlayGoals:           return "PPG"
            case .powerPlayPoints:          return "PPP"
            case .gameWinningGoals:         return "GWG"
            case .overTimeGoals:            return "OTG"
            case .shortHandedGoals:         return "SHG"
            case .shortHandedPoints:        return "SHP"
            case .blocked:                  return "BKS"
            case .plusMinus:                return "+/-"
            }
        }

    }
    
    enum goalieStat: String {
        case gamesPlayed            =      "Games Played"
        case wins                   =      "Wins"
        case shutouts               =      "Shutouts"
        case losses                 =      "Losses"
        case ot                     =      "Overtime Losses"
        case saves                  =      "Saves"
        case savePercentage         =      "Save Percent"
        case goalsAgainstAverage    =      "GAA"
        
        static let allValues = [gamesPlayed,
                                wins,
                                shutouts,
                                losses,
                                ot,
                                saves,
                                savePercentage,
                                goalsAgainstAverage]
        
        var abbreviation: String {
            switch self {
            case .gamesPlayed:              return "GP"
            case .wins:                     return "W"
            case .shutouts:                 return "SHO"
            case .losses:                   return "L"
            case .ot:                       return "OTL"
            case .saves:                    return "SA"
            case .savePercentage:           return "SV%"
            case .goalsAgainstAverage:      return "GAA"
            }
        }
    }
}
