import SpriteKit

class SpaceshipScene: SKScene {
    //當切換到這個場景檢視後後
    override func didMoveToView(view: SKView) {
        createScene()
    }
    func createScene(){
        
        let spaceship = newSpaceship()
        //設定飛船的位置
        spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150)
        //加入到場景中
        self.addChild(spaceship)
        //產生隕石
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "addRock", userInfo: nil, repeats: true)
    }
    //建立飛創的類別
    func newSpaceship()->SKShapeNode{
        //建立一個橢圓，充當飛船
        let ship = SKShapeNode()
        ship.path = CGPathCreateWithRoundedRect(CGRectMake(-15, -15, 30, 30), 15, 15, nil)
        ship.strokeColor = SKColor.whiteColor()
        ship.fillColor = SKColor.grayColor()
        //建立一群組動作，暫停1秒，位移，暫停1秒，位移
        let hover = SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(100, y: 50, duration: 1),
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(-100, y: -50, duration: 1.0)
            ])
        //以重復的模式執行序列動作
        ship.runAction(SKAction.repeatActionForever(hover))
        //建立燈光
        let light1 = newLight()
        //設定燈光位置
        light1.position = CGPointMake(-28, 6.0)
        //載入燈光
        ship.addChild(light1)
        
        //建立燈光2，步驟同上
        let light2 = newLight()
        light2.position = CGPointMake(28, 6.0)
        ship.addChild(light2)
        
        
        //實體系統
        ship.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ship.physicsBody?.dynamic = false
        
        //傳回飛船
        return ship
    }
    //建立燈光方法
    func newLight()->SKShapeNode{
        //建立一個黃色橢圓充當燈光
        let light = SKShapeNode()
        light.path = CGPathCreateWithRoundedRect(CGRectMake(-4, -4, 8, 8), 4, 4, nil)
        light.strokeColor = SKColor.whiteColor()
        light.fillColor = SKColor.yellowColor()
        //建立忽明忽暗的動作
        let blink = SKAction.sequence([
            SKAction.fadeOutWithDuration(0.25),
            SKAction.fadeInWithDuration(0.25)
            ])
        //建立一直重復的動作
        let blinkForever = SKAction.repeatActionForever(blink)
        //執行動作
        light.runAction(blinkForever)
        //傳回燈光
        return light
    }
    
    //建立隕石的方法
    func addRock(){
        //小橢圓充當隕石
        let rock = SKShapeNode()
        rock.path = CGPathCreateWithRoundedRect(CGRectMake(-4, -4, 8, 8), 4, 4, nil)
        rock.strokeColor = SKColor.whiteColor()
        rock.fillColor = SKColor.brownColor()
        //取得場景寬，高
        let w = self.size.width
        let h = self.size.height
        //隨機出現在場景的xy位置
        let x = CGFloat(arc4random())%w
        let y = CGFloat(arc4random())%h
        //設定隕石的位置
        rock.position = CGPointMake(x,y)
        //設定隕石的name屬性
        rock.name = "rock"
        //給隕石設定實體體
        rock.physicsBody = SKPhysicsBody(circleOfRadius: 4)
        //實體體容許檢驗碰撞
        rock.physicsBody?.usesPreciseCollisionDetection = true
        //場景加入隕石
        self.addChild(rock)
        
    }

}
