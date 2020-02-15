import SpriteKit

class AppleFactory:SKNode{
    //定義蘋果紋理
    let appleTexture = SKTexture(imageNamed: "apple")
    //游戲場景的狂賭
    var sceneWidth :CGFloat = 0.0
    //定義蘋果陣列
    var arrApple = [SKSpriteNode]()
    //定時器
    var timer = NSTimer()
    //蘋果高度
    var theY :CGFloat = 0.0
    
    func onInit(width:CGFloat, y:CGFloat) {
        
        self.sceneWidth = width
        self.theY = y
        //啟動的定時器
        timer = NSTimer.scheduledTimerWithTimeInterval( 0.2, target: self, selector: "createApple", userInfo: nil, repeats: true)
    }
    //建立蘋果類別
    func createApple(){
        //透過隨機數來隨機產生蘋果
        //算法是，隨機產生0-9的數，當隨機數大於8的時候聲稱蘋果
        //也就是說，有1/10的機率產生蘋果
        //這樣游戲場景中的蘋果就不會整整齊齊以相同間隔出現了
        let random = arc4random() % 10
        if random > 8 {
            //產生蘋果
            let apple = SKSpriteNode(texture: appleTexture)
            //設定實體體
            apple.physicsBody = SKPhysicsBody(rectangleOfSize: apple.size)
            //彈性設為0
            apple.physicsBody?.restitution = 0
            //實體體標誌
            apple.physicsBody?.categoryBitMask = BitMaskType.apple
            //不受實體效果影響
            apple.physicsBody?.dynamic = false
            //設定中心點
            apple.anchorPoint = CGPointMake(0, 0)
            //z軸深度
            apple.zPosition = 40
            //設定位置
            apple.position  = CGPointMake(sceneWidth+apple.frame.width , theY + 150)
            //加入陣列
            arrApple.append(apple)
            //加入場景
            self.addChild(apple)
        }
        
    }
    //蘋果搬移方法
    func move(speed:CGFloat){
        for apple in arrApple {
            apple.position.x -= speed
        }
        //移出螢幕外時移除蘋果
        if arrApple.count > 0 && arrApple[0].position.x < -20{
            
            arrApple[0].removeFromParent()
            arrApple.removeAtIndex(0)
            
        }
    }
    //重設方法
    func reSet(){
        //移除所有子物件
        self.removeAllChildren()
        //清理蘋果陣列
        arrApple.removeAll(keepCapacity: false)
    }
}