//
//  NHLPlayer.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-10-31.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class NHLPlayer: Codable {
    var id: Int
    let fullName, link: String
    var team: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, link
        
    }
    
    init(decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.fullName = try valueContainer.decode(String.self, forKey: CodingKeys.fullName)
        self.link = try valueContainer.decode(String.self, forKey: CodingKeys.link)
        
    }
}
