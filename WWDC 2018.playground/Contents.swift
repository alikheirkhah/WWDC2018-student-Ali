//: ### run this playground on ipad and lanscape mode
//: I prefer you read the game rules before the game starts
//: # game rules :
//: 1. Find the emoji 😀 on the emoji pack that game creates for you
//: 2. You have 60 seconds ⏰ time
//: 3. If you hit the wrong emoji you get a (-) point but if correct you get a (+) point
//: 4. If you want to know more about me collect more than 10 emojis
//: ### surprise
//: I have a surprise for you after the game but make sure you play well because I need a lot of emojis for it to work. By the way my highscore is 22 😜
//: # about me :
//: When it comes to the surprise part make sure you hold the ipad still facing the ground.
import SpriteKit
import PlaygroundSupport
import UIKit
import ARKit

let mainFrame = CGRect(x: 0, y: 0, width: 640, height: 480)
let mainView = SKView(frame: mainFrame)
mainView.showsFPS = false
mainView.showsNodeCount = false
mainView.showsPhysics = false
let scene = BootScene(fileNamed: "Scenes/BootScene" )
scene?.scaleMode = .aspectFit
mainView.presentScene(scene)
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = mainView
