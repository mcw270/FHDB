//
//  Utilities.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-25.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import Foundation

func combineAndFilterArrays(keyArray: [Any], valueArray: [Double]) -> [(Any, Double)]? {
    
    if keyArray.count != valueArray.count {
        return nil
    }
    var combinedArray: [(Any, Double)] = []
    
    for (index, element) in keyArray.enumerated() {
        combinedArray.append((element, valueArray[index]))
    }
    
    let filteredCombinedArray = combinedArray.filter({ $0.1 != 0 })
    return filteredCombinedArray
}

