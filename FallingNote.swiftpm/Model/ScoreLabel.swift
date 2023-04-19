//
//  ScoreLabel.swift
//  Color
//
//  Created by Michele Trombone  on 05/04/23.
//

import SpriteKit

class ScoreLabel {
    var scoreLabelNode = SKLabelNode(text: "0")
    
    init(frame: CGRect) {
        scoreLabelNode.fontSize = 60.0
        scoreLabelNode.fontName = "SF-Pro"
        scoreLabelNode.fontColor = UIColor.white
        scoreLabelNode.position = CGPoint(x: frame.maxX - 70, y: frame.maxY - 100)
        scoreLabelNode.zPosition = 3
    }
    
    func updateScore(score: Int) {
        scoreLabelNode.text = "\(score)"
    }
}
