//
//  Utilities.swift
//  Color
//
//  Created by Michele Trombone  on 05/04/23.
//
import SpriteKit
import SwiftUI
import AVFoundation

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let noteCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}

enum ZPositions {
    static let label: CGFloat = 0
    static let note: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}

enum LayoutProperties {
    static let backgroundColor: UIColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 0)
}

enum PlayColors {
    static let colors = [
        UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), // bianco
        UIColor(red: 211/255, green: 110/255, blue: 112/255, alpha: 1.0), // rosa
        UIColor(red: 126/255, green: 138/255, blue: 252/255, alpha: 1.0), // blu
        UIColor(red: 228/255, green: 220/255, blue: 0/255, alpha: 1.0) // giallo
        ]
}

enum PlayColorsBlindness {
    static let colorsBlindness = [
        UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), // bianco
        UIColor(red: 153/255, green: 124/255, blue: 105/255, alpha: 1.0), // rosa
        UIColor(red: 2/255, green: 135/255, blue: 233/255, alpha: 1.0), // blu
        UIColor(red: 254/255, green: 180/255, blue :86/255, alpha: 1.0) // giallo
        ]
}

var colorBlindness = UserDefaults.standard.bool(forKey: "colorBlindnessKey")
var noteSetting = UserDefaults.standard.bool(forKey: "noteSettingKey")


var checkFirstOpen = UserDefaults.standard.integer(forKey: "FirstOpen")

var easyModeFlag : Bool = false
var difficultModeFlag : Bool = false

let maxScreenSizeWidth : Int = 5000
let maxScreenSizeHeight : Int = 5000

let color1: CGColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1).cgColor
let color2: CGColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
    .cgColor
let color3: CGColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor

let startPoint = CGPoint(x: 0.5, y: -0.2)
let endPoint = CGPoint(x: 0.5, y: 1)

var player : AVAudioPlayer!

// INITIALIZE SOUND STRUCT

// leva il formato evenutalmente una volta capito come far partire le musiche

var doNote = SoundEffectNote(name: "do", sound: "do.mp3")
var reNote = SoundEffectNote(name: "re", sound: "re.mp3")
var miNote = SoundEffectNote(name: "mi", sound: "mi.mp3")
var faNote = SoundEffectNote(name: "fa", sound: "fa.mp3")
var solNote = SoundEffectNote(name: "sol", sound: "sol.mp3")
var laNote = SoundEffectNote(name: "la", sound: "la.mp3")
var siNote = SoundEffectNote(name: "si", sound: "si.mp3")

var soundEffectVec: [SoundEffectNote] = [doNote,reNote,miNote,faNote,solNote,laNote,siNote]

var soundEffectInno:[SoundEffectNote] = [miNote,miNote,faNote,solNote,solNote,faNote,miNote,reNote,doNote,doNote,reNote,miNote,miNote,reNote,reNote,miNote,miNote,faNote,solNote,solNote,faNote,miNote,reNote,doNote,doNote,reNote,miNote,reNote,doNote,reNote,reNote,miNote,doNote,reNote,miNote,faNote,miNote,doNote,reNote,miNote,faNote,miNote,reNote,doNote,reNote,solNote,solNote,miNote,miNote,faNote,solNote,solNote,faNote,miNote,reNote,doNote,doNote,reNote,miNote,reNote,reNote]


