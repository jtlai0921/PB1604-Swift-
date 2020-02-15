import SpriteKit

class HelloScene: SKScene {
    //當切換到這個場景檢視後後
    override func didMoveToView(view: SKView) {
        createScene()
    }
    func createScene(){
        //改變背景彩色
        self.backgroundColor = SKColor.blueColor()
        //建立一個顯示文字的節點
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        //加入name屬性
        myLabel.name = "label"
        //設定文字內容
        myLabel.text = "Hello, 鎮叔";
        //設定字型大小
        myLabel.fontSize = 65;
        //設定文字節點的位置
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        //將文字節點加入場景中
        self.addChild(myLabel)
    }
    //響應螢幕點擊時間的方法
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //取得文字節點
        let labelNode = self.childNodeWithName("label")
        //向上搬移的動作
        let moveUp = SKAction.moveByX(0, y: 100, duration: 0.5)
        //拉近動作
        let zoom = SKAction.scaleTo(2.0, duration: 0.25)
        //暫停的動作
        let pause = SKAction.waitForDuration(0.5)
        //淡出的動作
        let fadeAway = SKAction.fadeOutWithDuration(0.25)
        //從父物件移除的動作
        let remove = SKAction.removeFromParent()
        //動作序列
        let moveSequence = SKAction.sequence([moveUp,zoom,pause,fadeAway,remove])
        //文字節點執行動作序列
//        labelNode?.runAction(moveSequence)
        //執行完動作序列之後呼叫閉包函數
        labelNode?.runAction(moveSequence, completion: {
            //宣告下一個場景的案例
            let spaceshipScene = SpaceshipScene(size: self.size)
            //場景過渡動畫
            let doors = SKTransition.doorsOpenVerticalWithDuration(0.5)
            //帶動畫的場景跳躍
            self.view?.presentScene(spaceshipScene,transition:doors)
        })
        
        
    }
   
}
