//
//  Switch.swift
//  Color
//
//  Created by Michele Trombone  on 05/04/23.
//

import SpriteKit
import Foundation

class Switch {
    var spriteNode: SKSpriteNode!
    var violinKey: SKSpriteNode!
    var state = State.red
    var stateDouble = StateDouble.red

    enum State: Int {
        case red, yellow, green, blue
    }
    enum StateDouble: Int {
        case red, yellow
    }
    
    init(frame: CGRect) {
        spriteNode = SKSpriteNode(imageNamed: "Pentagram")
        spriteNode.size = CGSize(width: 300, height: 110)
        spriteNode.position = CGPoint(x: frame.midX, y: frame.minY + spriteNode.size.height)
        spriteNode.zPosition = ZPositions.colorSwitch
        spriteNode.physicsBody = SKPhysicsBody(rectangleOf: spriteNode.size)
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        spriteNode.physicsBody?.isDynamic = false
        spriteNode.colorBlendFactor = 1
        spriteNode.color = PlayColors.colors[0]

    }
    
    func changeColorPentagram() {
        if let newState = State(rawValue: state.rawValue + 1) {
            state = newState
        } else {
            state = .red
        }
    }
    
    func changeColorStaffDouble() {
        if let newState = StateDouble(rawValue: stateDouble.rawValue + 1) {
            stateDouble = newState
            print(stateDouble)
        } else {
            stateDouble = .red
            print(stateDouble)
        }
    }
    
}
