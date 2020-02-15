//平台類別
import SpriteKit

class Platform:SKNode{
    //寬
    var width :CGFloat = 0.0
    //高
    var height :CGFloat = 10.0
    
    //是否下沉
    var isDown = false
    //是否升降
    var isShock = false

    func onCreate(arrSprite:[SKSpriteNode]){
        //透過接受SKSpriteNode陣列來建立平台
        for platform in arrSprite {
            //以目前寬度為平台零件的x座標
            platform.position.x = self.width
            //載入
            self.addChild(platform)
            //更新寬度
            self.width += platform.size.width
        }
        //當平台的零件只有三樣，左中右時，設為會下落的平台
        if arrSprite.count<=3 {
            isDown = true
        }else{
            //若果超過3，則有30%的機率稱為會升降的平台
            let random = arc4random()%10
            if random > 6 {
                isShock = true
            }
        }
        
        self.zPosition = 20
        //設定實體體為目前高寬群組成的矩形
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.width, self.height), center: CGPointMake(self.width/2, 0))
        //設定實體標誌
        self.physicsBody?.categoryBitMask = BitMaskType.platform
        //不響應響應實體效果
        self.physicsBody?.dynamic = false
        //不旋轉
        self.physicsBody?.allowsRotation = false
        //彈性0
        self.physicsBody?.restitution = 0
    }
}
