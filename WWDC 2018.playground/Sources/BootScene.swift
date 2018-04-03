 import SpriteKit
 import PlaygroundSupport
 extension String{
    static func randomEmoji()->String{
        let emojiStart = 0x1F601
        let ascii = emojiStart + Int(arc4random_uniform(UInt32(64)))
        let emoji = UnicodeScalar(ascii)?.description
        return emoji!
    }
 }
 public class BootScene: SKScene {
    var mainScanner = SKSpriteNode()
    var emoji = SKLabelNode()
    public override func didMove(to view: SKView) {
        //////////////////////SKNodes
        mainScanner = childNode(withName: "mainScanner") as! SKSpriteNode
        emoji = childNode(withName: "emoji") as! SKLabelNode
        //////////////////////Variables
        let playBootSound = SKAction.playSoundFileNamed("Sounds/Startup", waitForCompletion: true)
        let moveScannerRight = SKAction.moveTo(x: 120, duration: 2)
        let moveScannerLeft  = SKAction.moveTo(x: -130, duration: 1)
        //////////////////////Actions
        self.run(playBootSound)
        self.run(SKAction.repeat(SKAction.sequence([SKAction.run {
            self.emoji.text = String.randomEmoji()
            LoginScene.labelText = self.emoji.text!
            },SKAction.wait(forDuration: 0.15)]), count: 60))
        mainScanner.run(SKAction.repeatForever(SKAction.sequence([moveScannerRight , moveScannerLeft])))
        self.run(SKAction.sequence([SKAction.wait(forDuration: 10),
                                    SKAction.run {
                                        
                                        let nextScene = LoginScene(fileNamed: "Scenes/LoginScene")
                                        nextScene?.scaleMode = .aspectFit
                                        view.presentScene(nextScene)
            }]))
    }
    public override func update(_ currentTime: TimeInterval) {
    }
 }
