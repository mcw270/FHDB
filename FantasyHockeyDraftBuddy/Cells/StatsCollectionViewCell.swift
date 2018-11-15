//
//  StatsCollectionViewCell.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-07.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var statCellLabel: UILabel!
    @IBOutlet weak var statCategoryLabel: UILabel!
    
    func update(with stat: String, category: String) {
        statCellLabel.text = stat
        statCategoryLabel.text = category
    }
    
    override func prepareForReuse() {
        statCellLabel.text = ""
        statCategoryLabel.text = ""
    }
}
