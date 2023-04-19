//
//  Settings.swift
//  Color
//
//  Created by Michele Trombone  on 09/04/23.
//

import SpriteKit
import SwiftUI

class SettingScene: SKScene
{
    var back : SKSpriteNode = SKSpriteNode()
    var toggleColorBlidness: SKLabelNode = SKLabelNode()
    var toggleSettingColorBlindnessOnOff : SKLabelNode = SKLabelNode()
    var settingsTitle: SKLabelNode = SKLabelNode()
    var toggleNote: SKLabelNode = SKLabelNode()
    var toggleSettingNoteOnOff : SKLabelNode = SKLabelNode()
    
//MARK: didMove
    override func didMove(to view: SKView) {
        layoutScene()
    }

//MARK: layoutScene
        
    func layoutScene() {
       
        addBackground()
        addBackButton()
        addTitle()
        addToggleColorBlindness()
        addToggleNote()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mainMenuScene = MainMenu(size: view!.bounds.size)
        
//        view!.presentScene(gameScene)
        let touch = touches.first!
        let location = touch.location(in: self)
            if(atPoint(location).name == "back"){
                view!.presentScene(mainMenuScene)
        }
        
        if(atPoint(location).name == "toggleSettingColorBlindnessOnOff" && colorBlindness == false){
            colorBlindness = true
            toggleSettingColorBlindnessOnOff.text = "ON"
        }
        
        else if(atPoint(location).name == "toggleSettingColorBlindnessOnOff" && colorBlindness == true){
            colorBlindness = false
            toggleSettingColorBlindnessOnOff.text = "OFF"
        }
        UserDefaults.standard.set(colorBlindness, forKey: "colorBlindnessKey")
        
        if(atPoint(location).name == "toggleSettingNoteOnOff" && noteSetting == false){
            noteSetting = true
            toggleSettingNoteOnOff.text = "ON"
        }
        else if(atPoint(location).name == "toggleSettingNoteOnOff" && noteSetting == true){
            noteSetting = false
            toggleSettingNoteOnOff.text = "OFF"
        }
        UserDefaults.standard.set(noteSetting, forKey: "noteSettingKey")
    }

    func addBackground(){
        let image: UIImage = UIImage.gradientImage(withBounds: self.frame, startPoint: startPoint, endPoint: endPoint, colors: [color1, color2,color3])
        let gradientTexture = SKTexture(image: image)
        let gradientNode = SKSpriteNode(texture: gradientTexture)
        gradientNode.size = CGSize(width: maxScreenSizeWidth, height: maxScreenSizeWidth)
        self.addChild(gradientNode)
    }
    
    func addToggleColorBlindness(){
        
        toggleColorBlidness = SKLabelNode(text: "COLOR BLINDNESS :")
        toggleColorBlidness.position = CGPoint(x: frame.minX + 150, y: frame.midY)
        toggleColorBlidness.name = "toggle"
        toggleColorBlidness.fontName = "SF Pro"
        toggleColorBlidness.fontColor = UIColor.white
        toggleColorBlidness.fontSize = 25
        addChild(toggleColorBlidness)
        
        toggleSettingColorBlindnessOnOff = SKLabelNode(text: "OFF")
        toggleSettingColorBlindnessOnOff.position  = CGPoint(x: frame.maxX - 40, y: frame.midY)
        toggleSettingColorBlindnessOnOff.name = "toggleSettingColorBlindnessOnOff"
        toggleSettingColorBlindnessOnOff.fontName = "SF Pro"
        toggleSettingColorBlindnessOnOff.fontColor = UIColor.white
        toggleSettingColorBlindnessOnOff.fontSize = 35
        addChild(toggleSettingColorBlindnessOnOff)
        
        if colorBlindness == true{
            toggleSettingColorBlindnessOnOff.text = "ON"
        }
        else{
            toggleSettingColorBlindnessOnOff.text = "OFF"
        }
    }
    
    
    func addToggleNote(){
        toggleNote = SKLabelNode(text: "NOTE ON SCREEN :")
        toggleNote.position = CGPoint(x: frame.minX + 150, y: frame.midY - 120)
        toggleNote.name = "toggleNote"
        toggleNote.fontName = "SF Pro"
        toggleNote.fontColor = UIColor.white
        toggleNote.fontSize = 25
        addChild(toggleNote)
        
        toggleSettingNoteOnOff = SKLabelNode(text: "")
        toggleSettingNoteOnOff.position  = CGPoint(x: frame.maxX - 40, y: frame.midY - 120)
        toggleSettingNoteOnOff.name = "toggleSettingNoteOnOff"
        toggleSettingNoteOnOff.fontName = "SF Pro"
        toggleSettingNoteOnOff.fontColor = UIColor.white
        toggleSettingNoteOnOff.fontSize = 35
        addChild(toggleSettingNoteOnOff)
        if noteSetting == true
        {
            toggleSettingNoteOnOff.text = "ON"
        }
        else
        {
            toggleSettingNoteOnOff.text = "OFF"
        }
    }
    
    
    func addTitle(){
        settingsTitle = SKLabelNode(text: "SETTINGS")
        settingsTitle.position = CGPoint(x: frame.minX + 130, y: frame.midY + 230)
        settingsTitle.name = "title"
        settingsTitle.fontName = "SF Pro"
        settingsTitle.fontColor = UIColor.white
        settingsTitle.fontSize = 40
        addChild(settingsTitle)
        
        let settingSubTitle = SKLabelNode(text: "Tap on text on / off for choose the accessibility mode")
        settingSubTitle.position = CGPoint(x: settingsTitle.position.x + 130, y:  settingsTitle.position.y - 60)
        settingSubTitle.name = "title"
        settingSubTitle.fontName = "SF Pro"
        settingSubTitle.fontColor = UIColor.white
        settingSubTitle.fontSize = 20
        addChild(settingSubTitle)
    }
    
    func addBackButton(){
        back = SKSpriteNode(imageNamed: "SFsymbol-back")
        back.position = CGPoint(x: frame.minX + 70, y: frame.midY + frame.size.height / 2.5)
        back.name = "back"
        back.size = CGSize(width: 50, height: 40)
        addChild(back)
    }
}
