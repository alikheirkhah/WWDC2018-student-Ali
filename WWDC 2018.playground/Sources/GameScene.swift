import SpriteKit
import PlaygroundSupport

public class GameScene: SKScene {
    var countdownArray = ["3️⃣", "2️⃣", "1️⃣"]
    var emojiDisplay = SKLabelNode()
    var guideText = SKLabelNode()
    var timeLabel = SKLabelNode()
    var readyButton = SKSpriteNode()
    var seperator = SKSpriteNode()
    var score = SKLabelNode()
    var tipCounter = SKLabelNode()
    static var scoreAmount = 0
    var tipNo = 0
    var time = 60
    var emojiBoardArray : [SKLabelNode]? = [SKLabelNode]()
    static var emojisCollected : [String]? = [String]()
    var saveRandomLabel = 0
    var emojiFlag = 0
    var changeFlag = 0
    public override func didMove(to view: SKView) {
        //////////////////////Constraints
        guideText = childNode(withName: "guideText") as! SKLabelNode
        readyButton = childNode(withName: "readyButton") as! SKSpriteNode
        score = childNode(withName: "score") as! SKLabelNode
        seperator = childNode(withName: "seperatorLine") as! SKSpriteNode
        timeLabel = childNode(withName: "timeLabel") as! SKLabelNode
        tipCounter = childNode(withName: "tips") as! SKLabelNode
        emojiDisplay = childNode(withName: "emojiDisplay") as! SKLabelNode
        //////////////////////SKNodes
        
        //////////////////////Variables
        
        //////////////////////Bodies
        
        //////////////////////Actions
        
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let finger = t.location(in: self)
            if (readyButton.contains(finger)){
                guideText.removeFromParent()
                readyButton.removeFromParent()
                seperator.run(SKAction.moveTo(y: 50, duration: 3))
                self.run(SKAction.sequence([SKAction.repeat(SKAction.sequence([SKAction.run {self.emojiDisplay.text = " " + self.countdownArray[0]},
                    SKAction.wait(forDuration: 1),
                    SKAction.run {self.countdownArray.removeFirst()}]), count: 3),
                    SKAction.run{
                    self.nextRandomEmoji()
                    self.randomEmojis()
                    let randomLabel = arc4random_uniform(8)
                    self.saveRandomLabel = Int(randomLabel)
                    self.emojiBoardArray![Int(randomLabel)].text = self.emojiDisplay.text
                    self.checkEmoji()
                    },SKAction.run{self.timer();self.emojiFlag = 1;self.changeFlag=1}]))
                }
            else if (self.contains(finger)){
                for i in 0...8{
                    if(emojiFlag == 1){
                    if (emojiBoardArray![i].contains(finger)){
                        if(emojiBoardArray![i].text == emojiDisplay.text){
                            emojiBoardArray![saveRandomLabel].text = "💥"
                            GameScene.emojisCollected?.append(emojiDisplay.text!)
                            self.run(SKAction.playSoundFileNamed("Sounds/Pop sound", waitForCompletion: true))
                            nextRandomEmoji()
                            GameScene.scoreAmount+=1
                            tips()
                        }
                        else if(emojiBoardArray![i].text != emojiDisplay.text){
                            emojiBoardArray![saveRandomLabel].text = "💥"
                            GameScene.emojisCollected?.append(emojiDisplay.text!)
                            self.run(SKAction.playSoundFileNamed("Sounds/wrong", waitForCompletion: true))
                            nextRandomEmoji()
                            if (GameScene.scoreAmount > 0){
                            GameScene.scoreAmount-=1
                            }
                            tips()
                        }
                      }
                    }
                  }
                }
              }
            }
    public override func update(_ currentTime: TimeInterval) {
        score.text = String(GameScene.scoreAmount)
        if(changeFlag == 1){
            changeFlag=0
            self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2),
                                                               SKAction.run{
                                                                self.randomEmojis()
                                                                let randomLabel = arc4random_uniform(8)
                                                                self.saveRandomLabel = Int(randomLabel)
                                                                self.emojiBoardArray![Int(randomLabel)].text = self.emojiDisplay.text
                                                                self.checkEmoji()
                }])))
        }
    }
    //////////////////////functions
    func nextRandomEmoji() {
        emojiDisplay.text = " " + String.randomEmoji()
    }
    func tips() {
        if(GameScene.scoreAmount <= 10){
        tipCounter.text = String(GameScene.scoreAmount)
            if (GameScene.scoreAmount == 10){
               tipCounter.fontColor = #colorLiteral(red: 0.5294117647, green: 0.8352941176, blue: 0.4509803922, alpha: 1)
            }
        }
    }
    func timer(){
        self.run(SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 1),
                                                    SKAction.run{self.time -= 1
                                                        if(self.time == 10){
                                                            self.timeLabel.fontColor = #colorLiteral(red: 0.8509803922, green: 0.3058823529, blue: 0.2235294118, alpha: 1)
                                                            self.timeLabel.alpha = 1.0
                                                        self.run(SKAction.playSoundFileNamed("Sounds/countdown", waitForCompletion: true))
                                                        }
                                                        if(self.time == 0){
                                                            PlaygroundPage.current.liveView = ARViewController()
                                                        }
                                                    },
                                                    SKAction.run{self.timeLabel.text = String(self.time)}]), count: 60))
    }
    func fillEmojiArrays(){
        for i in 1...9
        {
            if let sprite = self.childNode(withName: "\(i)") as? SKLabelNode {
                emojiBoardArray?.append(sprite)
            }
        }
    }
    func randomEmojis(){
        fillEmojiArrays()
        for i in 0...8{
            emojiBoardArray![i].text = String.randomEmoji()
        }
    }
    func checkEmoji() {
        for i in 0...8 {
            if(i != saveRandomLabel){
                if(" " + emojiBoardArray![i].text! == emojiBoardArray![saveRandomLabel].text){
                    emojiBoardArray![i].text = String.randomEmoji()
                    repeat{
                        emojiBoardArray![i].text = String.randomEmoji()
                    }while(" " + emojiBoardArray![i].text! == emojiBoardArray![saveRandomLabel].text)
                    
                }
            }
        }
    }
}
