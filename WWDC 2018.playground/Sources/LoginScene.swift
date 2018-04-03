import SpriteKit
import PlaygroundSupport
import UIKit
extension SKAction {
    class func shake(initialPosition:CGPoint, duration:Float, amplitudeX:Int = 12, amplitudeY:Int = 0) -> SKAction {
        let startingX = initialPosition.x
        let startingY = initialPosition.y
        let numberOfShakes = duration / 0.015
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let newXPos = startingX + CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let newYPos = startingY + CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            actionsArray.append(SKAction.move(to: CGPoint(x: newXPos, y: newYPos), duration: 0.015))
        }
        actionsArray.append(SKAction.move(to: initialPosition, duration: 0.015))
        return SKAction.sequence(actionsArray)
    }
}

public extension UIView {
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = -5) {
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation 
        layer.add(animation, forKey: "shake")
    }
}

public class LoginScene: SKScene {
    let loginField = UITextField()
    let helpImage = UIImage(named: "helpButton")
    let enterImage = UIImage(named: "enterButton")
    let helpButton = UIButton(type: UIButtonType.custom)
    let enterButton = UIButton(type: UIButtonType.custom)
    var loginPicture = SKLabelNode()
    var notificationBody = SKSpriteNode()
    var okayBtn = SKSpriteNode()
    static var labelText = ""
    public override func didMove(to view: SKView) {
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.borderStyle = UITextBorderStyle.roundedRect
        loginField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2992957746)
        loginField.font = UIFont.systemFont(ofSize: 10.0)
        loginField.isSecureTextEntry = true
        self.view?.addSubview(loginField)
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.setImage(helpImage, for: .normal)
        self.view?.addSubview(helpButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setImage(enterImage, for: .normal)
        enterButton.alpha = 1
        self.view?.addSubview(enterButton)
        loginPicture = childNode(withName: "loginPicture") as! SKLabelNode
        notificationBody = childNode(withName: "notificationBody") as! SKSpriteNode
        okayBtn = notificationBody.childNode(withName: "okayBtn") as! SKSpriteNode
        //////////////////////SKNodes
        helpButtonCons()
        loginFieldCons()
        enterButtonCons()
        //////////////////////Constraints
        
        //////////////////////Variables
        
        //////////////////////Bodies
        helpButton.addTarget(self, action: #selector(helpAction), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(checkPass), for: .touchUpInside)
        notificationBody.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.playSoundFileNamed("Sounds/notify.caf", waitForCompletion: true)
            ]))
        notificationBody.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.moveTo(x: 120, duration: 0.5),
            SKAction.run {
                self.okayBtn.move(toParent: self)
            }
            ]))
        loginPicture.text = LoginScene.labelText
        //////////////////////Actions
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc =  t.location(in: self)
            if okayBtn.contains(loc){
                okayBtn.move(toParent: notificationBody)
                notificationBody.run(SKAction.moveTo(x: 800, duration: 0.5))
            }
        }
    }
    public override func update(_ currentTime: TimeInterval) {
        /*if (loginField.text != ""){
         enterButton.alpha = 1
         }
         else if loginField.text == "" {
         enterButton.alpha = 0
         }*/
    }
    //////////////////////functions
    @objc func checkPass (){
        if loginField.text == "" {
            loginField.removeFromSuperview()
            helpButton.removeFromSuperview()
            enterButton.removeFromSuperview()
            let nextScene = GameScene(fileNamed: "Scenes/GameScene")
            nextScene?.scaleMode = .aspectFit
            view?.presentScene(nextScene!, transition: SKTransition.fade(withDuration: 0.1))
        }
        else{
            loginField.shake()
            helpButton.shake()
        }
    }
    @objc func helpAction(){
        okayBtn.move(toParent: notificationBody)
        notificationBody.run(SKAction.shake(initialPosition: CGPoint(x: notificationBody.position.x, y: notificationBody.position.y), duration: 2))
        self.run(SKAction.sequence([SKAction.wait(forDuration: 2.3),
                                    SKAction.run {self.okayBtn.move(toParent: self)}
            ]))
        
    }
    func loginFieldCons(){
        var fieldCons : [NSLayoutConstraint] = []
        let height =  loginField.heightAnchor.constraint(equalToConstant: 25)
        let width = loginField.widthAnchor.constraint(equalToConstant: 150)
        let xPlacement = loginField.centerXAnchor.constraint(equalTo: (self.view?.centerXAnchor)!)
        let yPlacement = loginField.centerYAnchor.constraint(equalTo: (self.view?.centerYAnchor)!, constant: 30)
        fieldCons = [height , width , xPlacement , yPlacement]
        NSLayoutConstraint.activate(fieldCons)
    }
    func helpButtonCons() {
        var helpCons : [NSLayoutConstraint] = []
        let height = helpButton.heightAnchor.constraint(equalToConstant: 12)
        let width = helpButton.widthAnchor.constraint(equalToConstant: 12)
        let xPlacement = helpButton.centerXAnchor.constraint(equalTo: (self.view?.centerXAnchor)!, constant: 63)
        let yPlacement = helpButton.centerYAnchor.constraint(equalTo: (self.view?.centerYAnchor)!, constant: 30)
        helpCons = [height , width , xPlacement , yPlacement]
        NSLayoutConstraint.activate(helpCons)
    }
    func enterButtonCons(){
        var enterCons : [NSLayoutConstraint] = []
        let height = enterButton.heightAnchor.constraint(equalToConstant: 19)
        let width = enterButton.widthAnchor.constraint(equalToConstant: 19)
        let xPlacement = enterButton.centerXAnchor.constraint(equalTo: (self.view?.centerXAnchor)!, constant: 90)
        let yPlacement = enterButton.centerYAnchor.constraint(equalTo: (self.view?.centerYAnchor)!, constant: 30)
        enterCons = [height , width , xPlacement , yPlacement]
        NSLayoutConstraint.activate(enterCons)
    }
}
