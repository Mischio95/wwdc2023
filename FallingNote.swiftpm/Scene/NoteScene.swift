//
//  MainMenu.swift
//  ColorKey
//
//  Created by Michele Trombone  on 05/04/23.
//

import Foundation
import SpriteKit
import UIKit
import AVFoundation
import AVFAudio

class NoteScene: SKScene, SKPhysicsContactDelegate
{
    var colorSwitch: Switch!
    var currentColorIndex: Int?
    var scoreLabel: ScoreLabel!
    var score = 0
    var gravity = -2.0
    var playBlingSound: SKAction?
    var audioPlayer: AVAudioPlayer?
    var textLabel: SKLabelNode!
    var textLabel2: SKLabelNode!
    var clicked = 0
    var noteLabel: SKLabelNode!
    
    override func update(_ currentTime: TimeInterval) {
       
    }
    
    //MARK: didMove
    
    override func didMove(to view: SKView) {
        
        setupPhysics()
        layoutScene()
        if noteSetting == true{
            noteLabel.isHidden = false
        }
        else{
            noteLabel.isHidden = true
        }
    }
    
    //MARK: touchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        colorSwitch.changeColorPentagram()
        clicked += 1
        if clicked == PlayColors.colors.count{
            clicked = 0
        }
        if colorBlindness == true{
            colorSwitch.spriteNode.color = PlayColorsBlindness.colorsBlindness[clicked]
        }
        else{
            colorSwitch.spriteNode.color = PlayColors.colors[clicked]
        }
    }
    
    func spawnNote(index: Int) {
        let colorSwitchSpawn = Switch(frame: frame)
        colorSwitchSpawn.spriteNode.color = PlayColors.colors[index]
        addChild(colorSwitchSpawn.spriteNode)
    }
    
    //MARK: didBegin
    
    func didBegin(_ contact: SKPhysicsContact){
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.noteCategory | PhysicsCategories.switchCategory {
            if let note = contact.bodyA.node?.name == "Note" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                detectColorMatch(note: note)
            }
        }
    }
    
    //MARK: detectColor
    
    func detectColorMatch(note: SKSpriteNode) {
        if currentColorIndex ==  colorSwitch.state.rawValue
        {
           
        if easyModeFlag == true
        {
            difficultModeFlag = false
            updateWorldGravityEasy()
        }
        
        if difficultModeFlag == true
        {
            easyModeFlag = false
            updateWorldGravityDifficult()
            scoreLabel.scoreLabelNode.fontColor = PlayColors.colors.randomElement()
        }
        score += 1
        scoreLabel.updateScore(score: score)
 
        run(SKAction.playSoundFileNamed(soundEffectInno[score-1].sound, waitForCompletion: false))
        
        noteLabel.text = soundEffectInno[score-1].name
        
            
        note.run(SKAction.fadeOut(withDuration: 0.25))
        {
            note.removeFromParent()
            self.spawnNote()
        }
    } else {
        note.run(SKAction.fadeOut(withDuration: 0.25))
        {
            note.removeFromParent()
            self.gameOver()
        }
        
    }
}
    
//MARK: updateGravity in easy mode

    func updateWorldGravityEasy() {
        gravity -= 0.2
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
    }
    
//MARK: updateGravity in difficult mode
    
    func updateWorldGravityDifficult() {
        gravity -= 0.4
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
    }
    
    
//MARK: set Physics ball
    
    func setupPhysics()  {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity)
        physicsWorld.contactDelegate = self
    }
  
//MARK: LayoutScene
    
    func layoutScene() {
       addBackground()
        
        colorSwitch = Switch(frame: frame)
        addChild(colorSwitch.spriteNode)

        scoreLabel = ScoreLabel(frame: frame)
        addChild(scoreLabel.scoreLabelNode)
        scoreLabel.scoreLabelNode.isHidden = true

        let handImage = SKSpriteNode(imageNamed: "SFsymbol-hand.tap")
        handImage.position.x = frame.midX
        handImage.position.y = frame.midY
        handImage.size = CGSize(width: 40, height: 50)
        addChild(handImage)
        animate(node: handImage)
        
        let text = SKLabelNode(text: "Name of symphony: Ode to joy")
        text.fontName = "SF pro"
        text.color = UIColor.white
        text.position.x = frame.midX
        text.position.y = frame.midY - 100
        text.fontSize = 25
        addChild(text)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            handImage.removeFromParent()
            text.removeFromParent()
            self.scoreLabel.scoreLabelNode.isHidden = false
            self.spawnNote()
        }
       
        noteLabel = SKLabelNode(text: "")
        noteLabel.position.x  = frame.minX + 50
        noteLabel.position.y  = frame.maxY - 100
        noteLabel.fontName = "SF-Pro"
        noteLabel.fontColor = UIColor.white
        noteLabel.fontSize = 40
        addChild(noteLabel)
    }
    
    //MARK: animate SKSPritenode ScaleUp - ScaleDown
    
    func animate(node: SKSpriteNode) {
        let scaleUp = SKAction.scale(to: 1.3, duration: 0.6)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.6)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        node.run(SKAction.repeatForever(sequence))
    }
    
//MARK: spawn
    
    func spawnNote() {
        if colorBlindness == true
        {
            let randomColor = PlayColorsBlindness.colorsBlindness.randomElement()
            currentColorIndex = PlayColorsBlindness.colorsBlindness.firstIndex(of: randomColor!)
            let note = Note(frame: frame, color: randomColor!)
            addChild(note.spriteNode)
        }
        else
        {
            let randomColor = PlayColors.colors.randomElement()
            currentColorIndex = PlayColors.colors.firstIndex(of: randomColor!)
            let note = Note(frame: frame, color: randomColor!)
            addChild(note.spriteNode)
        } 
    }
    
//MARK: GameOver
    
    func gameOver() {
            run(SKAction.playSoundFileNamed("GameOver.wav", waitForCompletion: false)) {
            UserDefaults.standard.set(self.score, forKey: "RecentScore")
            if self.score > UserDefaults.standard.integer(forKey: "HighScore") {
                UserDefaults.standard.set(self.score, forKey: "HighScore")
            }
                
                let textGameOver = SKLabelNode(text: "GAME OVER")
                textGameOver.fontName = "SF Pro"
                textGameOver.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                textGameOver.fontSize = 40
                textGameOver.fontColor = UIColor.white
                self.addChild(textGameOver)
                self.animate(label: textGameOver)

                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    let menuScene = MainMenu(size: self.view!.bounds.size)
                    let transition = SKTransition.fade(withDuration: 1)
                    self.view!.presentScene(menuScene, transition: transition)
                }
        }
    }
    
    func addBackground()
    {
        let image: UIImage = UIImage.gradientImage(withBounds: self.frame, startPoint: startPoint, endPoint: endPoint, colors: [color1, color2,color3])
        let gradientTexture = SKTexture(image: image)
        let gradientNode = SKSpriteNode(texture: gradientTexture)
        gradientNode.size = CGSize(width: maxScreenSizeWidth, height: maxScreenSizeWidth)
        self.addChild(gradientNode)
        
        if let particles = SKEmitterNode(fileNamed: "Particles") {
            particles.position = CGPoint(x: frame.midX, y: frame.minY)
            particles.particleSize = CGSize(width: frame.width,height: frame.height)
            particles.zPosition = gradientNode.zPosition + 1
            addChild(particles)
        }
    }
    
    
    func animate(label: SKLabelNode) {
        let scaleUp = SKAction.scale(to: 1.4, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
}
