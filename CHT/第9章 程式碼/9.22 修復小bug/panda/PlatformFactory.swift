import SpriteKit

class PlatformFactory: SKNode {
    //定義平台左邊紋理
    let textureLeft = SKTexture(imageNamed: "platform_l")
    //定義平台中間紋理
    let textureMid = SKTexture(imageNamed: "platform_m")
    //定義平台右邊紋理
    let textureRight = SKTexture(imageNamed: "platform_r")

    //定義一個陣列來儲存群組裝後的平台
    var platforms = [Platform]()
    
    //游戲場景的寬度
    var sceneWidth:CGFloat = 0
    //ProtocolMainScene代理
    var delegate:ProtocolMainScene?
    
    //產生自訂位置的平台
    func createPlatform(midNum:UInt32,x:CGFloat,y:CGFloat){
        let platform = self.createPlatform(false, midNum: midNum, x: x, y: y)
        delegate?.onGetData(platform.width - sceneWidth,theY: y)
    }
    
    //產生隨機位置的平台的方法
    func createPlatformRandom(){
        //隨機平台的長度
        let midNum:UInt32 = arc4random()%4 + 1
        //隨機間隔
        let gap:CGFloat = CGFloat(arc4random()%8 + 1)
        //隨機x座標
        let x:CGFloat = self.sceneWidth + CGFloat( midNum*50 ) + gap + 100
        //隨機y座標
        let y:CGFloat = CGFloat(arc4random()%200 + 200)
        
        let platform = self.createPlatform(true, midNum: midNum, x: x, y: y)
        //回傳距離用於判斷什麼時候產生新的平台
        delegate?.onGetData(platform.width + x - sceneWidth,theY:y)
        
    }
    
    func createPlatform(isRandom:Bool,midNum:UInt32,x:CGFloat,y:CGFloat)->Platform{
        //宣告一個平台類別，用來群組裝平台。
        let platform = Platform()
        //產生平台的左邊零件
        let platform_left = SKSpriteNode(texture: textureLeft)
        //設定中心點
        platform_left.anchorPoint = CGPoint(x: 0, y: 0.9)
        //產生平台的右邊零件
        let platform_right = SKSpriteNode(texture: textureRight)
        //設定中心點
        platform_right.anchorPoint = CGPoint(x: 0, y: 0.9)
        
        //宣告一個陣列來存放平台的零件
        var arrPlatform = [SKSpriteNode]()
        //將左邊零件加入零件陣列
        arrPlatform.append(platform_left)
        
        //根據傳入的參數來決定要群組裝幾個平台的中間零件
        //然後將中間的零件加入零件陣列
        for i in 1...midNum {
            let platform_mid = SKSpriteNode(texture: textureMid)
            platform_mid.anchorPoint = CGPoint(x: 0, y: 0.9)
            arrPlatform.append(platform_mid)
        }
        //將右邊零件加入零件陣列
        arrPlatform.append(platform_right)
        //將零件陣列傳入
        platform.onCreate(arrPlatform)
        platform.name="platform"
        //設定平台的位置
        platform.position = CGPoint(x: x, y: y)
        //放到目前案例中
        self.addChild(platform)
        //將平台加入平台陣列
        platforms.append(platform)
        return platform
    }
    func move(speed:CGFloat){
        //檢查所有
        for p in platforms{
            //x座標的變化長生水平搬移的動畫
            p.position.x -= speed
        }
        //移除平台
        if platforms[0].position.x < -platforms[0].width {
            platforms[0].removeFromParent()
            platforms.removeAtIndex(0)
        }
    }
    //重設方法
    func reSet(){
        //清除所有子物件
        self.removeAllChildren()
        //清理平台陣列
        platforms.removeAll(keepCapacity: false)
    }
}
//定義一個協定，用來接收資料
protocol ProtocolMainScene {
    func onGetData(dist:CGFloat,theY:CGFloat)
}