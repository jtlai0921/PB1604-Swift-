import SpriteKit

class GameScene: SKScene {
    let pointContainer = PointContainer()
    
    //当切换到这个场景视图后
    override func didMoveToView(view: SKView) {
//        println("\(self.frame)")
        //将Images.xcassets中的bg.jpg 来制作背景
        let bg = SKSpriteNode(imageNamed: "bg")
        //设置位置
        bg.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));

        self.addChild(bg)
        
        //设置圆点容器
        pointContainer.position = CGPoint(x:CGRectGetMidX(self.frame)-10, y:CGRectGetMidY(self.frame)-150);
        self.addChild(pointContainer)
        pointContainer.onInit()
    }
    //响应屏幕点击的方法
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch:AnyObject in touches{
            //获取点击的坐标
            let location = touch.locationInNode(self)
            //该坐标下所有的对象
            let arrObject = self.nodesAtPoint(location)
            //找出为EkoPoint类型的对象
            for p in arrObject {
                let point = p as? EkoPoint
                //如果该对象不为nil，而且是灰色的点，就开始寻路
                if point != nil && point!.type != PointType.red {
                    pointContainer.onGetNextPoint(point!.index)
                }
            }
            
        }
    }

}
