//
//  MainMenu.swift
//  Color
//
//  Created by Michele Trombone  on 05/04/23.
//

import SpriteKit

class MainMenu: SKScene {
    
    var normalButton = SKSpriteNode(imageNamed: "")
    var tutorialButton = SKSpriteNode(imageNamed: "")
    var settings = SKSpriteNode(imageNamed: "")
    
//MARK: didMove
    override func didMove(to view: SKView) {
        layoutScene()
    }

//MARK: layoutScene
    
    func layoutScene() {
        checkFirstOpen += 1
        UserDefaults.standard.set(checkFirstOpen, forKey: "FirstOpen")
        print(checkFirstOpen)
        addBackground()
        addLogo()
        addLables()
        addButton()
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "Logo")
        logo.size = CGSize(width: 180, height: 140)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height / 4)
        addChild(logo)
//        animateLogo(logo: logo)
    }

    func addLables() {
        let playLabel = SKLabelNode(text: "FALLINGNOTE")
        playLabel.fontName = "SF-Pro"
        playLabel.fontSize = 40
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY + 60)
        addChild(playLabel)
        animate(label: playLabel)
        
        let selectMode = SKLabelNode(text: "TAP Mode to play")
        selectMode.fontName = "SF-Pro"
        selectMode.name = "Mode"
        selectMode.fontSize = 30
        selectMode.fontColor = UIColor.white
        selectMode.position = CGPoint(x: frame.midX, y: frame.midY - 44)
        addChild(selectMode)
        
        let highScoreLabel = SKLabelNode(text: "Best score: \(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = "SF-Pro"
        highScoreLabel.fontSize = 30
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height * 10)
        addChild(highScoreLabel)

        let recentScoreLab = SKLabelNode(text: "Recent score: \(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentScoreLab.fontName = "SF-Pro"
        recentScoreLab.fontSize = 30
        recentScoreLab.fontColor = UIColor.white
        recentScoreLab.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - recentScoreLab.frame.size.height * 3)
        addChild(recentScoreLab)
        
        settings = SKSpriteNode(imageNamed: "SFsymbol-gearshape")
        settings.position = CGPoint(x: frame.maxX - 40, y: frame.midY + frame.size.height / 2.5)
        settings.name = "settings"
        settings.size = CGSize(width: 40, height: 40)
        addChild(settings)
    }
    
    func addButton()
    {
        normalButton = SKSpriteNode(imageNamed: "Normal-Button")
        normalButton.name = "NormalMode"
        normalButton.position = CGPoint(x: frame.midX + 100 , y: frame.midY - 130)
        normalButton.size = CGSize(width: 180, height: 70)
        addChild(normalButton)
        
        tutorialButton = SKSpriteNode(imageNamed: "Tutorial-Button")
        tutorialButton.name = "TutorialMode"
        tutorialButton.position = CGPoint(x: frame.midX - 100 , y: frame.midY - 130)
        tutorialButton.size = CGSize(width: 180, height: 70)
        addChild(tutorialButton)
    }

//MARK: animate SKLabelNode ScaleUp - ScaleDown
    
    func animate(label: SKLabelNode) {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        var colorAction = SKAction()
        if colorBlindness == true
        {
            colorAction = SKAction.colorize(with: PlayColorsBlindness.colorsBlindness.randomElement()!, colorBlendFactor: 1, duration: 0.1)
        }
        else
        {
            colorAction = SKAction.colorize(with: PlayColors.colors.randomElement()!, colorBlendFactor: 1, duration: 0.1)
        }
       
        let sequence = SKAction.sequence([colorAction, scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
    
//MARK: animate SKSpriteNode Rotation
    
    func animateLogo(logo: SKSpriteNode) {
        let rotation = SKAction.rotate(byAngle: CGFloat(2), duration: 0.5)
        logo.run(SKAction.repeatForever(rotation))
    }
    
//MARK: touchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tutorialScene = TutorialScene(size: view!.bounds.size)
        let settingScene = SettingScene(size: view!.bounds.size)
        let noteScene = NoteScene(size: view!.bounds.size)
        
//        view!.presentScene(gameScene)
        let touch = touches.first!
        let location = touch.location(in: self)
            if(atPoint(location).name == "NormalMode"){
                run(SKAction.playSoundFileNamed("ButtonClick.mp3", waitForCompletion: false))
                normalButton.alpha = 0.6
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    self.view!.presentScene(noteScene)
                }
                easyModeFlag = true
                difficultModeFlag = false
                
            }
        else if (atPoint(location).name == "TutorialMode")
        {
            run(SKAction.playSoundFileNamed("ButtonClick.mp3", waitForCompletion: false))
            tutorialButton.alpha = 0.6
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.view!.presentScene(tutorialScene)
            }
            
            easyModeFlag = false
            difficultModeFlag = true
           
        }
        else if (atPoint(location).name == "settings")
        {
            run(SKAction.playSoundFileNamed("ButtonClick.mp3", waitForCompletion: false))
            settings.alpha = 0.7
            view!.presentScene(settingScene)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        normalButton.alpha = 1
        tutorialButton.alpha = 1
        settings.alpha = 1
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

//MARK: extension UIImage for set gradient color background

extension UIImage {
    static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint , colors: [CGColor]) -> UIImage {
        
        // Configure the gradient layer based on input
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = withBounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        // Render the image using the gradient layer
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
