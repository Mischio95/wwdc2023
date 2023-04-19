//
//  GameScene.swift
//  Color
//
//  Created by Michele Trombone  on 05/04/23.
//

import Foundation
import SpriteKit
import UIKit
import AVFoundation
import AVFAudio



class TutorialScene: SKScene, SKPhysicsContactDelegate
{
    var colorSwitch: Switch!
    var currentColorIndex: Int?
    var scoreLabel: ScoreLabel!
    var score = 0
    var gravity = -2.0
    var playBlingSound: SKAction?
    var ballSound: String = "GameBallBounce"
    var audioPlayer: AVAudioPlayer?
    var textLabel: SKLabelNode!
    var textLabel2: SKLabelNode!
    var clicked = 0
    var noteLabel: SKLabelNode!
    var countTutorial = 0
    
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
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                detectColorMatch(ball: ball)
            }
        }
    }
    
    //MARK: detectColor
    
    func detectColorMatch(ball: SKSpriteNode) {
        if currentColorIndex ==  colorSwitch.state.rawValue
        {
           countTutorial += 1
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
            
        ball.run(SKAction.fadeOut(withDuration: 0.25))
        {
            ball.removeFromParent()
            if self.countTutorial == 1
            {
                self.scene?.isPaused = true
                
                self.scoreLabel.scoreLabelNode.removeFromParent()
                
                let textLabel = SKLabelNode(text: "PERFECT!")
                textLabel.position  = CGPoint(x: self.frame.midX, y: self.frame.midY)
                textLabel.fontName = "SF-Pro"
                textLabel.fontColor = UIColor.white
                textLabel.fontSize = 20
                self.addChild(textLabel)
                
                let textLabel2 = SKLabelNode(text: "you matched the color, KEEP IT UP!")
                textLabel2.position.x  = self.frame.midX
                textLabel2.position.y  = self.frame.midY - 100
                textLabel2.fontName = "SF-Pro"
                textLabel2.fontColor = UIColor.white
                textLabel2.fontSize = 20
                self.addChild(textLabel2)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    textLabel.removeFromParent()
                    textLabel2.removeFromParent()
                    let transition = SKTransition.fade(with: .black, duration: 1)
                    let menuScene = MainMenu(size: self.view!.bounds.size)
                    self.view!.presentScene(menuScene, transition: transition)
                    
                }
            }
        }
    } else {
        ball.run(SKAction.fadeOut(withDuration: 0.25))
        {
            ball.removeFromParent()
            self.spawnBall()
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
        
        textLabel = SKLabelNode(text: "TAP THE SCREEN FOR CHANGE COLOR OF PENTAGRAM")
        textLabel.position  = CGPoint(x: frame.midX, y: frame.midY)
        textLabel.fontName = "SF-Pro"
        textLabel.fontColor = UIColor.white
        textLabel.fontSize = 20
        addChild(textLabel)
        
        textLabel2 = SKLabelNode(text: "AND REMID THE SEQUENCE")
        textLabel2.position.x  = frame.midX
        textLabel2.position.y  = frame.midY - 100
        textLabel2.fontName = "SF-Pro"
        textLabel2.fontColor = UIColor.white
        textLabel2.fontSize = 20
        addChild(textLabel2)
        
        let textLabel3 = SKLabelNode(text: "Welkome to FALLINGNOTE")
        textLabel3.position.x  = frame.midX
        textLabel3.position.y  = frame.maxY - 200
        textLabel3.fontName = "SF-Pro"
        textLabel3.fontColor = UIColor.white
        textLabel3.fontSize = 25
        addChild(textLabel3)
        
        let textLabel4 = SKLabelNode(text: "TUTORIAL")
        textLabel4.position.x  = frame.midX
        textLabel4.position.y  = frame.maxY - 300
        textLabel4.fontName = "SF-Pro"
        textLabel4.fontColor = UIColor.white
        textLabel4.fontSize = 30
        addChild(textLabel4)
        
        let handImage = SKSpriteNode(imageNamed: "SFsymbol-hand.tap")
//        handImage.position.x = colorSwitch.spriteNode.position.x + 140
//        handImage.position.y = colorSwitch.spriteNode.position.y - 20
        handImage.position.x = frame.midX
        handImage.position.y = frame.midY + 100
        handImage.size = CGSize(width: 30, height: 40)
        addChild(handImage)
        animate(node: handImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6){
            handImage.removeFromParent()
            self.textLabel.removeFromParent()
            self.textLabel2.removeFromParent()
            textLabel3.removeFromParent()
            textLabel4.removeFromParent()
            self.scoreLabel.scoreLabelNode.isHidden = false
            self.spawnBall()
        }
       
        noteLabel = SKLabelNode(text: "")
        noteLabel.position.x  = scoreLabel.scoreLabelNode.position.x
        noteLabel.position.y  = scoreLabel.scoreLabelNode.position.y - 200
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
    
    func spawnBall() {
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
            let menuScene = MainMenu(size: self.view!.bounds.size)
            self.view!.presentScene(menuScene)
        }
    }
    
    func addBackground()
    {
        let image: UIImage = UIImage.gradientImage(withBounds: self.frame, startPoint: startPoint, endPoint: endPoint, colors: [color1, color2,color3])
        let gradientTexture = SKTexture(image: image)
        let gradientNode = SKSpriteNode(texture: gradientTexture)
        gradientNode.size = CGSize(width: maxScreenSizeWidth, height: maxScreenSizeWidth)
        self.addChild(gradientNode)
    }
}
