//
//  PlayerTableViewCell.swift
//  FantasyHockeyDraftBuddy
//
//  Created by Matthew Wheeler on 2018-11-03.
//  Copyright © 2018 Matthew Wheeler. All rights reserved.
//

import UIKit

protocol playerTableDelegate {
    func playerTablePanGesture(offset: CGPoint)
    func starTapped(sender: PlayerTableViewCell)
}

var currentOffset: CGPoint?

class PlayerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var statsCollectionView: UICollectionView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTeamAndPositionLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    
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
            } else {
                statsArray = ["-", "-", "-", "-", "-", "-"]
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
        delegate?.playerTablePanGesture(offset: CGPoint(x: -sender.translation(in: self).x, y: 0))
        sender.setTranslation(.zero, in: self)
    }
    
    func setScrollingOffsetAfterGesture(offset: CGPoint) {
        
        let newOffset = statsCollectionView.contentOffset.x + offset.x
        
        var minContentOffset: CGPoint {
            return CGPoint(
                x: -statsCollectionView.contentInset.left,
                y: 0)
        }
        
        var maxContentOffset: CGPoint {
            return CGPoint(
                x: statsCollectionView.contentSize.width - statsCollectionView.bounds.width + statsCollectionView.contentInset.right,
                y: 0)
        }
        
        if newOffset <= maxContentOffset.x && newOffset >= minContentOffset.x {
            statsCollectionView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: false)
            currentOffset = statsCollectionView.contentOffset
        }
        
    }
    
    func setOffset() {
        guard let currentOffset = currentOffset else { return }
        statsCollectionView.setContentOffset(currentOffset, animated: false)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerImageView.image = nil
        playerTeamAndPositionLabel.text = ""
        playerNameLabel.text = ""
        statsCollectionView.reloadData()
    }
    
    @IBAction func starButtonTapped(_ sender: Any) {
        delegate?.starTapped(sender: self)
    }
    
    func update() {
        
        if let player = player {
        
        playerNameLabel.text = player.person.fullName
            
        playerTeamAndPositionLabel.text = "\(player.person.team) - \(player.position.abbreviation.rawValue)"
        
            APIController.fetchPlayerImage(playerId: player.person.id, completion: { (playerImage) in
                DispatchQueue.main.async {
                    self.playerImageView.image = playerImage
                }
            })
        }
    }
}


