import PlaygroundSupport
import UIKit
import SpriteKit
import ARKit

class ARViewController : UIViewController, ARSKViewDelegate,ARSessionDelegate{
    var ARSceneView = ARSKView()
    override func loadView() {
        
        ARSceneView =  ARSKView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        ARSceneView.delegate = self
        
        if let scene = SKScene(fileNamed: "Scenes/ARScene"){
            ARSceneView.presentScene(scene)
        }
        
        let ARConfiguration = ARWorldTrackingConfiguration()
        
        ARConfiguration.planeDetection = .horizontal
        ARSceneView.session.delegate = self
        self.view =  ARSceneView
        ARSceneView.session.run(ARConfiguration)
    }
    func view(_ view: ARSKView,nodeFor anchor: ARAnchor) -> SKNode {
        
        let spriteNode = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        if (GameScene.scoreAmount >= 10){
            spriteNode.text = "your score is: \(GameScene.scoreAmount)          hello, my name is ali and   I am 16 y.o 🔥 I am from Iran 🇮🇷 . I have been to Germany 🇩🇪 and Japan 🇯🇵 for 2 years of robocup ⚽️ (2016-2017)"
        } else {
            spriteNode.text = "your score is: \(GameScene.scoreAmount)"
        }
        spriteNode.numberOfLines = 0
        spriteNode.preferredMaxLayoutWidth = 185
        spriteNode.fontSize = 15
        spriteNode.fontColor = #colorLiteral(red: 0.2196078431, green: 0.4823529412, blue: 0.9411764706, alpha: 1)
        spriteNode.horizontalAlignmentMode = .center
        spriteNode.verticalAlignmentMode = .center
        return spriteNode
    }
    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    func sessionWasInterrupted(_ session: ARSession) {
    }
    func sessionInterruptionEnded(_ session: ARSession) {
    }
}
public class ARScene: SKScene {
    
    public override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
