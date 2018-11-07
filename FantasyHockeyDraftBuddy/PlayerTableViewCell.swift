//
//  PlayerTableViewCell.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-03.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

protocol playerTableDelegate {
    func playerTableDelegate(offset: CGPoint, gesture: UIPanGestureRecognizer)
}

class PlayerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var delegate: playerTableDelegate?
    var player: RosterElement?
    var statsArray: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(PlayerTableViewCell.scrolled(_:)))
        addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
        statsCollectionView.delegate = self
        statsCollectionView.dataSource = self
        
    }
    
    func setPlayer(_ player: RosterElement) {
        self.player = player
            if let goals = player.stats?.goals,
                let assists = player.stats?.assists,
                let points = player.stats?.points,
                let pim = player.stats?.pim,
                let blocks = player.stats?.blocked,
                let faceoff = player.stats?.faceOffPct {
    
                    let goalsString = String(goals)
                    let assistsString = String(assists)
                    let pointsString = String(points)
                    let pimString = String(pim)
                    let blocksString = String(blocks)
                    let faceoffString = String(faceoff)
    
                    statsArray = [goalsString, assistsString, pointsString, pimString, blocksString, faceoffString]
                }
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
        delegate?.playerTableDelegate(offset: CGPoint(x: -sender.translation(in: self).x, y: 0), gesture: sender)
    }
    
    func setScrollingOffset(offset: CGPoint, gesture: UIPanGestureRecognizer) {
        statsCollectionView.setContentOffset(offset, animated: false)
        gesture.setTranslation(.zero, in: self)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let statsArray = statsArray else {return 0}
        return statsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsCell", for: indexPath) as! StatsCollectionViewCell
        
        let stat = statsArray?[indexPath.row]
        
        cell.update(with: stat!)
        
        return cell
    }
    
    func update() {
        
        playerNameLabel.text = player?.person.fullName
    }
}


