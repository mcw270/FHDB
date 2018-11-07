//
//  PlayerTableViewCell.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-03.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

protocol playerTableDelegate {
    func playerTableDelegate(offset: CGPoint)
}

class PlayerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var statsScrollView: UIScrollView!
    @IBOutlet weak var statsStackView: UIStackView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var delegate: playerTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(PlayerTableViewCell.scrolled(_:)))
        addGestureRecognizer(panGesture)
        panGesture.delegate = self
        // Initialization code
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) {
            let panRecognizer = gestureRecognizer as! UIPanGestureRecognizer

            if abs(panRecognizer.velocity(in: self).x) > abs(panRecognizer.velocity(in: self).y) {
                return true

            }
        }
        return false
    }

    @objc func scrolled(_ sender: UIPanGestureRecognizer) {
        print(sender.translation(in: self).x)
        delegate?.playerTableDelegate(offset: CGPoint(x: -sender.translation(in: self).x, y: 0))
    }
    
    func setScrollingOffset(offset: CGPoint) {
        statsScrollView.setContentOffset(statsScrollView.contentOffset, animated: false)
        statsScrollView.setContentOffset(offset, animated: false)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with: RosterElement) {
        
        for view in statsStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        if let goals = with.stats?.goals,
            let assists = with.stats?.assists,
            let points = with.stats?.points,
            let pim = with.stats?.pim,
            let blocks = with.stats?.blocked,
            let faceoff = with.stats?.faceOffPct {
            
                let goalsString = String(goals)
                let assistsString = String(assists)
                let pointsString = String(points)
                let pimString = String(pim)
                let blocksString = String(blocks)
                let faceoffString = String(faceoff)
            
                let statsArray: [String] = [goalsString, assistsString, pointsString, pimString, blocksString, faceoffString]
            
                var index = 0
                for stat in statsArray {
                    let textView = UILabel()
                    textView.text = String(stat)
                    textView.font = UIFont.systemFont(ofSize: 11)
                    textView.widthAnchor.constraint(equalToConstant: 50).isActive = true
                    index += 1
                    
                    statsStackView.addArrangedSubview(textView)
                }
            
            }
        
        playerNameLabel.text = with.person.fullName
    }
}


