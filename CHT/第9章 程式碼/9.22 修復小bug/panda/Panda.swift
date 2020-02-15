import SpriteKit

enum Status:Int{
    case run=1,jump,jump2,roll;
}

class Panda : SKSpriteNode {
    //跑的紋理集
    let runAtlas = SKTextureAtlas(named: "run.atlas")
    //跑的紋理陣列
    var runFrames = [SKTexture]()
    //跳的紋理集
    let jumpAtlas = SKTextureAtlas(named: "jump.atlas")
    //儲存跳的文理的陣列
    var jumpFrames = [SKTexture]();
    //打滾的文理集合
    let rollAtlas = SKTextureAtlas(named: "roll.atlas")
    //儲存打滾文理的陣列
    var rollFrames = [SKTexture]();
    
    var status = Status.run
    
    //起跳 y座標
    var jumpStart:CGFloat = 0.0
    //落地 y座標
    var jumpEnd :CGFloat = 0.0
    
    //起跳特效紋理集
    let jumpEffectAtlas = SKTextureAtlas(named: "jump_effect.atlas")
    //儲存七條特效紋理的陣列
    var jumpEffectFrames = [SKTexture]()
    //起跳特效
    var jumpEffect = SKSpriteNode()
    
    //建構器
    init() {
        let texture = runAtlas.textureNamed("panda_run_01")
        let size = texture.size()
        super.init(texture:texture,color:SKColor.whiteColor(),size:size)
        
        var i:Int
        //填充跑的紋理陣列
        for i=1 ; i<=runAtlas.textureNames.count ; i++ {
            let tempName = String(format: "panda_run_%.2d", i)
            let runTexture = runAtlas.textureNamed(tempName)
            
                runFrames.append(runTexture)
            
        }
        //填充跳的紋理陣列
        for i=1 ; i<=jumpAtlas.textureNames.count ; i++ {
            let tempName = String(format: "panda_jump_%.2d", i)
            let jumpTexture = jumpAtlas.textureNamed(tempName)
            
                jumpFrames.append(jumpTexture)
            
        }
        //填充打滾的紋理陣列
        for i=1 ; i<=rollAtlas.textureNames.count ; i++ {
            let tempName = String(format: "panda_roll_%.2d", i)
            let rollTexture = rollAtlas.textureNamed(tempName)
            
                rollFrames.append(rollTexture)
            
        }
        //起跳特效
        for i=1 ; i <= jumpEffectAtlas.textureNames.count ; i++ {
            let tempName = String(format: "jump_effect_%.2d", i)
            let effectexture = jumpEffectAtlas.textureNamed(tempName)
            
                jumpEffectFrames.append(effectexture)
            
        }
        
        jumpEffect = SKSpriteNode(texture: jumpEffectFrames[0])
        jumpEffect.position = CGPointMake(-80, -30)
        jumpEffect.hidden = true
        self.addChild(jumpEffect)
        
        run()
        
        self.zPosition = 30
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize:texture.size())
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        //彈性
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = BitMaskType.panda
        self.physicsBody?.contactTestBitMask = BitMaskType.platform | BitMaskType.scene|BitMaskType.apple
        self.physicsBody?.collisionBitMask = BitMaskType.platform
    }
    
    func run(){
        //移除所有的動作
        self.removeAllActions()
        //將目前動作狀態設為跑
        self.status = .run
        //透過SKAction.animateWithTextures將跑的文理陣列設定為0.05秒切換一次的動畫
        // SKAction.repeatActionForever將讓動畫永遠執行
        // self.runAction執行動作形成動畫
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(runFrames, timePerFrame: 0.05)))
    }
    //跳
    func jump (){
        self.removeAllActions()
        if status != Status.jump2 {
            self.runAction(SKAction.animateWithTextures(jumpFrames, timePerFrame: 0.05))
            //施加一個向上的力，讓熊貓跳起來
            self.physicsBody?.velocity = CGVectorMake(0, 450)
            if status == Status.jump {
                status = Status.jump2
                self.jumpStart = self.position.y
            }else{
                showJumpEffect()
                status = Status.jump
            }
        }
    }
    //打滾
    func roll(){
        self.removeAllActions()
        status = .roll
        self.runAction(SKAction.animateWithTextures(rollFrames, timePerFrame: 0.05),completion:{() in self.run()})
    }
    //起跳特效
    func showJumpEffect(){
        //先將特效取消隱藏
        jumpEffect.hidden = false
        //利用action播放特效
        let ectAct = SKAction.animateWithTextures( jumpEffectFrames, timePerFrame: 0.05)
        //執行閉包，再次隱藏特效
        let removeAct = SKAction.runBlock({() in
            self.jumpEffect.hidden = true
        })
        //群組成序列Action進行執行
        jumpEffect.runAction(SKAction.sequence([ectAct,removeAct]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
