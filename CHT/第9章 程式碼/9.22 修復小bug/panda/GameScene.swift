import SpriteKit

class GameScene: SKScene,ProtocolMainScene,SKPhysicsContactDelegate{
    lazy var panda = Panda()
    lazy var platformFactory = PlatformFactory()
    lazy var bg = BackGround()
    lazy var appleFactory = AppleFactory()
    lazy var sound = SoundManager()
    
    //跑多遠文字node
    var scoreLab = SKLabelNode(fontNamed:"Chalkduster")
    //吃了多少個蘋果文字node
    var appLab = SKLabelNode(fontNamed:"Chalkduster")
    //跑了多遠變數
    var distance :CGFloat = 0.0
    //吃了多少個蘋果變數
    var appleNum = 0
    
    
    //搬移速度
    var moveSpeed:CGFloat = 15
    //最大速度
    var maxSpeed :CGFloat = 50.0
    //判斷最後一個平台還有多遠完全進入游戲場景
    var lastDis:CGFloat = 0.0
    
    var theY:CGFloat = 0.0
    
    //是否game over
    var isLose = false
    
    override func didMoveToView(view: SKView) {
        //實體世界代理
        self.physicsWorld.contactDelegate = self
        //重力設定
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        //設定實體體
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //設定種類別標示
        self.physicsBody?.categoryBitMask = BitMaskType.scene
        //是否響應實體效果
        self.physicsBody?.dynamic = false
        
        
        //場景的背景彩色
        let skyColor = SKColor(red:113/255,green:197/255,blue:207/255,alpha:1)
        self.backgroundColor = skyColor
        
        //將計分板文字節點加入游戲場景
        //設定對齊方向
        scoreLab.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        //設定位置
        scoreLab.position = CGPointMake(20, self.frame.size.height-150)
        //預設顯示文字
        scoreLab.text = "run: 0 km"
        //加入游戲場景
        self.addChild(scoreLab)
        
        appLab.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        appLab.position = CGPointMake(400, self.frame.size.height-150)
        appLab.text = "eat: \(appleNum) apple"
        self.addChild(appLab)
        
        //設定背景
        self.addChild(bg)
        
        
        //給熊貓定一個起始位置
        panda.position = CGPointMake(200, 400)
        //將熊貓顯示在場景中
        self.addChild(panda)
        //將平台工廠加入檢視
        self.addChild(platformFactory)
        //將螢幕的寬度傳到平台工廠類別中
        platformFactory.sceneWidth = self.frame.width
        //設定代理
        platformFactory.delegate = self
        //起始平台讓熊貓有立足之地
        platformFactory.createPlatform(3, x: 0, y: 200)
        //蘋果工廠
        appleFactory.onInit(self.frame.width, y: theY)
        self.addChild( appleFactory )
        
        //將音效管理案例加入游戲場景中
        self.addChild(sound)
        //播放背景音樂
        sound.playBackGround()
        
    }
    //觸碰螢幕響應的方法

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        if isLose {
            reSet()
        }else{
            if panda.status != Status.jump2 {
                //若果處於2段跳狀態則不播放起跳音效
                sound.playJump()
            }
            panda.jump()
        }
        
    }
    //離開平台時記錄起跳點
    func didEndContact(contact: SKPhysicsContact!){
        panda.jumpStart = panda.position.y
        
    }
    //碰撞檢驗方法
    func didBeginContact(contact: SKPhysicsContact!) {
        //熊貓和蘋果碰撞
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.apple | BitMaskType.panda){
            //播放吃蘋果音效
            sound.playEat()
            //蘋果計數加1
            self.appleNum++
            //若果碰撞體A是蘋果，隱藏碰撞體A，反之隱藏碰撞體B
            if contact.bodyA.categoryBitMask == BitMaskType.apple {
                contact.bodyA.node?.hidden = true
            }else{
                
                contact.bodyB.node?.hidden = true
            }
            
            
        }
        
        
        //熊貓和台子碰撞
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask) == (BitMaskType.platform | BitMaskType.panda){
            //假設平台不會下沉，用於給後面判斷平台是否會被熊貓震的顫抖
            var isDown = false
            //用於判斷接觸平台後能否轉變為跑的狀態，預設值為false不能轉換
            var canRun = false
            //若果碰撞體A是平台
            if contact.bodyA.categoryBitMask == BitMaskType.platform {
                //若果是會下沉的平台
                if (contact.bodyA.node as! Platform).isDown {
                    isDown = true
                    //讓平台接收重力影響
                    contact.bodyA.node?.physicsBody?.dynamic = true
                    //不將碰撞效果取消，平台下沉的時候會跟著熊貓跑這不是我們希望看到的，
                    //大家可以將這行注解掉看看效果
                    contact.bodyA.node?.physicsBody?.collisionBitMask = 0
                    //若果是會升降的平台
                }else if (contact.bodyA.node as! Platform).isShock {
                    (contact.bodyA.node as! Platform).isShock = false
                    downAndUp(contact.bodyA.node!, down: -50, downTime: 0.2, up: 100, upTime: 1, isRepeat: true)
                }
                
                if contact.bodyB.node?.position.y > contact.bodyA.node!.position.y {
                    canRun=true
                }
                //若果碰撞體B是平台
            }else if contact.bodyB.categoryBitMask == BitMaskType.platform  {
                if (contact.bodyB.node as! Platform).isDown {
                    contact.bodyB.node?.physicsBody?.dynamic = true
                    contact.bodyB.node?.physicsBody?.collisionBitMask = 0
                    isDown = true
                }else if (contact.bodyB.node as! Platform).isShock {
                    (contact.bodyB.node as! Platform).isShock = false
                    downAndUp(contact.bodyB.node!, down: -50, downTime: 0.2, up: 100, upTime: 1, isRepeat: true)
                }
                if contact.bodyA.node?.position.y > contact.bodyB.node?.position.y {
                    canRun=true
                }
                
            }
            
            //判斷是否打滾
            panda.jumpEnd = panda.position.y
            if panda.jumpEnd-panda.jumpStart <= -70 {
                //播放打滾音效
                sound.playRoll()
                panda.roll()
                //若果平台下沉就不讓它被震得顫抖一下
                if !isDown {
                    downAndUp(contact.bodyA.node!)
                    downAndUp(contact.bodyB.node!)
                }
            }else{
                if canRun {
                    panda.run()
                }
            }
            
        }
        
        //若果熊貓和場景邊緣碰撞
        if (contact.bodyA.categoryBitMask|contact.bodyB.categoryBitMask) == (BitMaskType.scene | BitMaskType.panda) {
            print("游戲結束")
            //播放游戲結束的音效
            sound.playDead()
            isLose = true
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        //若果熊貓出現了位置偏差，就逐漸還原
        if panda.position.x < 200 {
            let x = panda.position.x + 1
            panda.position = CGPointMake(x, panda.position.y)
        }
        if !isLose {
            lastDis -= moveSpeed
            //速度以5為基礎，以跑的距離除以2000為增量
            var tempSpeed = CGFloat(5 + Int(distance/2000))
            //將速度控制在maxSpeed
            if tempSpeed > maxSpeed {
                tempSpeed = maxSpeed
            }
            //若果搬移速度小於新的速度就改變
            if moveSpeed < tempSpeed {
                moveSpeed = tempSpeed
            }
            
            if lastDis <= 0 {
                platformFactory.createPlatformRandom()
            }
            platformFactory.move(self.moveSpeed)
            bg.move(moveSpeed/5)
            appleFactory.move(moveSpeed)
            //更新計分板訊息
            distance += moveSpeed
            scoreLab.text = "run: \(Int(distance/1000*10)/10) km"
            appLab.text = "eat: \(appleNum) apple"
        }
        
    }
    
    func onGetData(dist:CGFloat,theY:CGFloat){
        self.lastDis = dist
        self.theY = theY
        appleFactory.theY = theY
        
    }
    
    //up and down 方法
    func downAndUp(node :SKNode,down:CGFloat = -50,downTime:Double=0.05,up:CGFloat=50,upTime:Double=0.1,isRepeat:Bool=false){
        //下沉動作
        let downAct = SKAction.moveByX(0, y: down, duration: downTime)
        //上升動過
        let upAct = SKAction.moveByX(0, y: up, duration: upTime)
        //下沉上升動作序列
        let downUpAct = SKAction.sequence([downAct,upAct])
        if isRepeat {
            node.runAction(SKAction.repeatActionForever(downUpAct))
        }else {
            node.runAction(downUpAct)
        }
    }
    
    //重新開始游戲
    func reSet(){
        //重設isLose變數
        isLose = false
        //重設熊貓位置
        panda.position = CGPointMake(200, 400)
        //重設搬移速度
        moveSpeed  = 15.0
        //重設跑的距離
        distance = 0.0
        //重設首個平台完全進入游戲場景的距離
        lastDis = 0.0
        //重設吃了蘋果的數量
        self.appleNum = 0
        //平台工廠的重設方法
        platformFactory.reSet()
        //蘋果工廠的重設方法
        appleFactory.reSet()
        //建立一個起始的平台給熊貓一個立足之地
        platformFactory.createPlatform(3, x: 0, y: 200)
    }

}
