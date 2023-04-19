//
//  File.swift
//  
//
//  Created by Michele Trombone  on 14/04/23.
//
import AVFoundation
import UIKit

class SoundManager {

    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: String) {
        let path = Bundle.main.path(forResource: sound, ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        do{
            player = try AVAudioPlayer(contentsOf: url)
        }
        catch{
            print(error.localizedDescription)
        }
        player?.play()
    }
}
