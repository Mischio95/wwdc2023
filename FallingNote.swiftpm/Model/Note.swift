//
//  Note.swift
//  Color
//
//  Created by Michele Trombone  on 06/04/23.
//

import SpriteKit

class Note {
    var spriteNode: SKSpriteNode!

    init(frame: CGRect, color: UIColor) {
        spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "NoteImage"), color: color, size: CGSize(width: 20, height: 30))
        spriteNode.colorBlendFactor = 1
        spriteNode.name = "Note"
        spriteNode.position = CGPoint(x: frame.midX, y: frame.maxY)
        spriteNode.zPosition = ZPositions.note
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.size.width / 2)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategories.noteCategory
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        spriteNode.physicsBody?.collisionBitMask = PhysicsCategories.none
    }
    
}
