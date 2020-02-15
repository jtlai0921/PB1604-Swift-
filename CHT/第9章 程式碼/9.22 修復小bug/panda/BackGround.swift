
import SpriteKit

class BackGround :SKNode {
    //近處背景陣列
    var arrBG = [SKSpriteNode]()
    //遠處背景陣列
    var arrFar = [SKSpriteNode]()
    
    override init() {
        super.init()
        //取得遠處背景的紋理
        let farTexture = SKTexture(imageNamed: "background_f1")
        //遠處背景由3章無縫圖銜接而成
        let farBg0 = SKSpriteNode(texture: farTexture)
        farBg0.anchorPoint = CGPointMake(0, 0)
        farBg0.zPosition = 9
        farBg0.position.y = 150
        
        let farBg1 = SKSpriteNode(texture: farTexture)
        farBg1.anchorPoint = CGPointMake(0, 0)
        farBg1.zPosition = 9
        farBg1.position.x = farBg0.frame.width
        farBg1.position.y = farBg0.position.y
        
        let farBg2 = SKSpriteNode(texture: farTexture)
        farBg2.anchorPoint = CGPointMake(0, 0)
        farBg2.zPosition = 9
        farBg2.position.x = farBg0.frame.width * 2
        farBg2.position.y = farBg0.position.y
        
        self.addChild(farBg0)
        self.addChild(farBg1)
        self.addChild(farBg2)
        arrFar.append(farBg0)
        arrFar.append(farBg1)
        arrFar.append(farBg2)
        
        
        //近處背景紋理
        let texture = SKTexture(imageNamed: "background_f0")
        //近處背景由2章無縫銜接圖群組成
        let bg0 = SKSpriteNode(texture: texture)
        bg0.anchorPoint = CGPointMake(0, 0)
        let bg1 = SKSpriteNode(texture: texture)
        bg1.anchorPoint = CGPointMake(0, 0)
        bg1.position.x = bg0.frame.width
        bg0.zPosition = 10
        bg1.zPosition = 10
        bg0.position.y = 40
        bg1.position.y = bg0.position.y
        self.addChild(bg0)
        self.addChild(bg1)
        arrBG.append(bg0)
        arrBG.append(bg1)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //搬移方法
    func move(speed:CGFloat){
        //透過檢查取得背景，然後做x方向的改變
        for bg in arrBG {
            bg.position.x -= speed
        }
        //循環卷動算法
        if arrBG[0].position.x + arrBG[0].frame.width < speed {
            arrBG[0].position.x = 0
            arrBG[1].position.x = arrBG[0].frame.width
        }
        //遠景同上
        
        for far in arrFar {
            far.position.x -= speed/4
        }
        if arrFar[0].position.x + arrFar[0].frame.width < speed/4 {
            arrFar[0].position.x = 0
            arrFar[1].position.x = arrFar[0].frame.width
            arrFar[2].position.x = arrFar[0].frame.width * 2
        }
    }
}
