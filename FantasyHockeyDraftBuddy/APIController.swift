//
//  playerController.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-29.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import Foundation

class APIController {
    
    static func fetchNHLInfo(completion: @escaping ([NHLTeam]) -> Void) {
        let baseURL = URL(string: "https://statsapi.web.nhl.com/api/v1/teams")!
        
        let query: [String: String] = [
            "expand": "team.roster",
            "active": "true"
        ]
        
        let url = baseURL.withQueries(query)!
        var allTeamList: [NHLTeam] = []
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let teams = try? jsonDecoder.decode(Teams.self, from: data) {
                    allTeamList = teams.teamList
                    completion(allTeamList)
            }
        }
        task.resume()

        
    }

    static func fetchStatistics(playerID: Int, completion: (@escaping (SplitStat?) -> Void)) {
        let baseURL = URL(string: "https://statsapi.web.nhl.com/api/v1/people/\(playerID)/stats")!

        let query: [String: String] = [
            "stats" : "statsSingleSeason",
            "season" : "20172018"
        ]

        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                let statistics = try! jsonDecoder.decode(Stats.self, from: data) 
                if let splitStat = statistics.statElementList.first?.statList.first?.stat {
                    completion(splitStat)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()


    }

}
