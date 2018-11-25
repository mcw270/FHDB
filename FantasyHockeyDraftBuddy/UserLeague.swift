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
    var positionSizes: [Position: Int]
    var scoring: [String: Int]
    var teams: [UserTeam]
    var playerList: [RosterElement]?
    var remainingRoster: [Position: Int]
    
    init(name: String, positionSizes: [Position: Int], scoring: [String: Int], teams: [UserTeam], playerList: [RosterElement]?) {
        self.name = name
        self.positionSizes = positionSizes
        self.scoring = scoring
        self.teams = teams
        self.playerList = playerList
        self.remainingRoster = positionSizes
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
    
    enum Position {
        case forward, leftWing, center, rightWing, defenseman, goalie, bench
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
    
    static func loadSampleData() -> [UserLeague] {
        let positions = [UserLeague.Position.leftWing: 5,
                         UserLeague.Position.center: 5,
                         UserLeague.Position.rightWing: 5,
                         UserLeague.Position.defenseman: 3,
                         UserLeague.Position.goalie: 2]
        
        let scoring: [String: Int] = ["G": 1, "A": 1, "P": 1]
        
        let team = UserTeam.init(name: "Test Team", players: nil, keepers: nil)
        
        let myLeague = UserLeague.init(name: "Test League", positionSizes: positions, scoring: scoring, teams: [team], playerList: nil)
        
        return [myLeague]
    }
    
}
