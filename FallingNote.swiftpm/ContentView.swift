import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var mainMenuScene: SKScene {
        let mainMenuScene = MainMenu()
        mainMenuScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mainMenuScene.scaleMode = .fill
        return mainMenuScene
     }
    
    var tutorialScene: SKScene {
        let tutorialScene = TutorialScene()
        tutorialScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tutorialScene.scaleMode = .fill
        return tutorialScene
     }
    
    var body: some View {
        
        GeometryReader { (geometry) in
    
            if checkFirstOpen == 0{
                let transition = SKTransition.fade(with: .black, duration: 2)
                SpriteView(scene: self.tutorialScene,transition: transition)
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
            else{
                SpriteView(scene: self.mainMenuScene)
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
