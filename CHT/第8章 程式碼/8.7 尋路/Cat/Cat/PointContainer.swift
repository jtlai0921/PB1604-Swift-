import SpriteKit

class PointContainer:SKNode,UIAlertViewDelegate{
    lazy var cat:Cat = Cat()
    
    //灰点纹理
    let textPoint1 = SKTexture(imageNamed: "pot1")
    //红点纹理
    let textPoint2 = SKTexture(imageNamed: "pot2")
    //记录所有圆点的数组
    var arrPoint = [EkoPoint]()
    //神经猫初始位置的圆点索引
    let startIndex = 40
    //神经猫所在的圆点索引
    var currIndex = 40
    //是否找到边缘点，true为找到了，false为没找到，没找到就代表游戏赢了
    var isFind = false
    //每次搜索的消耗次数
    var stepNum = 0
    //广度优先 记录外圈的点
    var arrNext = [Int]()
    
    func onInit(){
        for i in 0...80 {
            //默认为灰色点
            let point = EkoPoint(texture: textPoint1)
            //对行数除以9取整，用来为下面判断奇偶行做准备
            let row = Int(i/9)
            //列
            let col = i%9
            //x轴位移
            var gap = 0
            //奇偶行判断
            if Int(row % 2) == 1 {
                gap = Int(textPoint1.size().width)/2
            }else {
                
            }
            //取得纹理尺寸，用作计算位置
            let width = Int(textPoint1.size().width)
            //计算x坐标
            let x  = col * (width+5) - (9*width)/2 + gap
            //计算y坐标
            let y  = row * width - (9*width)/2
            //设置位置
            point.position = CGPointMake(CGFloat(x),CGFloat(y))
            //判断边缘
            if row == 0 || row == 8 || col == 0 || col == 8 {
                point.isEdge = true
            }
            //记录索引
            point.index = i
//            point.onSetLabel("\(i)")
            //设置z轴排序
            point.zPosition = 10
            //将点加入PointContainer中
            self.addChild(point)
            //将点加入数组中
            arrPoint.append(point)
        }
        //预先计算周围点
        onData()
        //随机生成红点
        onCreateRed()
        
        cat.position = onGetPosition(startIndex)
        cat.zPosition = 20
        self.addChild(cat)
    }
    //将每个点周围的点都存入点自身的arrPoint数组中
    func onData(){
        for point in arrPoint {
            let row = Int( point.index / 9 )
            if Int(row % 2) == 1 {
                if point.index - 1 >= 0 &&  point.index - 1<=80 {
                    point.arrPoint.append(point.index - 1)
                }
                if point.index + 9 >= 0 &&  point.index + 9 <= 80 {
                    point.arrPoint.append(point.index + 9)
                }
                if point.index + 10 >= 0 &&  point.index + 10 <= 80 {
                    point.arrPoint.append(point.index + 10)
                }
                if point.index + 1 >= 0 &&  point.index + 1 <= 80 {
                    point.arrPoint.append(point.index + 1)
                }
                if point.index - 8 >= 0 &&  point.index - 8 <= 80 {
                    point.arrPoint.append(point.index - 8)
                }
                if point.index - 9 >= 0 &&  point.index - 9 <= 80 {
                    point.arrPoint.append(point.index - 9)
                }
                
            } else {
                if point.index - 1 >= 0 &&  point.index - 1<=80 {
                    point.arrPoint.append(point.index - 1)
                }
                if point.index + 8 >= 0 &&  point.index + 8 <= 80 {
                    point.arrPoint.append(point.index + 8)
                }
                if point.index + 9 >= 0 &&  point.index + 9 <= 80 {
                    point.arrPoint.append(point.index + 9)
                }
                if point.index + 1 >= 0 &&  point.index + 1 <= 80 {
                    point.arrPoint.append(point.index + 1)
                }
                if point.index - 9 >= 0 &&  point.index - 9 <= 80 {
                    point.arrPoint.append(point.index - 9)
                }
                if point.index - 10 >= 0 &&  point.index - 10 <= 80 {
                    point.arrPoint.append(point.index - 10)
                }
                
            }
            
        }
    }
    //计算猫下一步怎么走 index 当前所在的点的索引
    func onGetNextPoint(index:Int){
        onSetRed(index)
        //判断下一步是否是出口点
        for point in arrPoint[currIndex].arrPoint {
            if arrPoint[point].isEdge &&  arrPoint[point].type == PointType.gray {
                cat.position = onGetPosition(arrPoint[point].index)
                let alert = UIAlertView(title: "", message: "你输了", delegate: self, cancelButtonTitle: "再来一次")
                alert.show()
                return
            }
        }
        //重置所有的step的值
        onResetStep()
        //设置原点
        let currPoint = arrPoint[currIndex]
        currPoint.onSetLabel("0")
        currPoint.step = 0
        
        arrNext.append(currIndex)
        //寻路开始
        onFind(arrNext)
        
        //打印消耗
        print("step:\(stepNum)")
        
        //寻路结束后根据isFind来判断游戏是赢了
        //还是继续围堵神经猫
        if !isFind {
            let alert = UIAlertView(title: "", message: "你赢了", delegate: self, cancelButtonTitle: "再来一次")
            alert.show()
            
        }
        
    }
    //获取广度优先的外圈点
    func onGetNexts(arrNext:[Int])->[Int]{
        //设置外圈点的setp的值
        let step = arrPoint[arrNext[0]].step + 1
        //临时的索引数组
        var tempPoints = [Int]()
        for nextP in arrNext {
            //如果找到边缘点则跳出循环
            if isFind {
                break
            }
            for p in arrPoint[nextP].arrPoint{
                self.stepNum += 1
                //如果找到边缘点，则将边缘点的文本内容设为“end”
                if arrPoint[p].isEdge && arrPoint[p].type == PointType.gray {
                    arrPoint[p].onSetLabel("end")
                    isFind = true
                    //找到边缘点后倒回去查找猫所在的点
                    onGetPrePoint(arrPoint[p])
                    break
                }
                //如果圆点的类别是灰色，且没有被搜索过
                //判断依据只要周边点step属性大于当前的step就表示没搜索过，因为没搜索过的时候step的默认值是99
                if ( arrPoint[p].type == PointType.gray ) && ( arrPoint[p].step > arrPoint[nextP].step ) {
                    //设置step值
                    arrPoint[p].step = step
                    //设置文本节点的内容
                    arrPoint[p].onSetLabel("\(step)")
                    //设置前一个圆点的索引
                    arrPoint[p].prePointIndex = arrPoint[nextP].index
                    //只要不是内圈点就加入临时数组
                    //不做这个判断会造成外圈相邻的两个圆点不停地相互搜索造成死循环
                    if arrPoint[p].index != arrPoint[nextP].prePointIndex {
                        tempPoints.append(p)
                    }
                }
            }
        }
        return tempPoints
    }
    //递归方法
    func onFind(arrPoint:[Int]){
        
        //如果找到，停止递归
        if !isFind {
            let arrNext = onGetNexts(arrPoint)
            if arrNext.count != 0 {
                onFind(arrNext)
            }
            
        }
    }
    //获得前一个点
    func onGetPrePoint(point:EkoPoint){
        //找到自己周围的点的setp小于当前点的step的圆点
        //以下的算法是找到当前这个点point周围step最小的圆点的索引值
        var p2 = point.arrPoint[0]
        for p in point.arrPoint {
            if arrPoint[p].step < arrPoint[p2].step{
                p2 = p
            }
        }
        //如果到达setp为0的圆点的周围，说明这个圆点就是神经猫要走的点
        if arrPoint[p2].step == 0 {
            //设置该点为神经猫的位置
            point.onSetLabel("next")
            cat.position = onGetPosition(point.index)
            //给当前点赋值
            self.currIndex = point.index
        }else{
            //如果没到神经猫附近，继续递归
            onGetPrePoint(arrPoint[p2])
        }
    }
    
    //随机生成红色的点
    func onCreateRed(){
        for i in 0...8 {
            let r1 = Int(arc4random() % 9) + i * 9
            let r2 = Int(arc4random() % 9) + i * 9
            if r1 != startIndex {
                onSetRed(r1)
            }
            if r2 != startIndex {
                onSetRed(r2)
            }
            
        }
    }
    //改变圆点类型
    func onSetRed(index:Int){
        arrPoint[index].type = PointType.red
        arrPoint[index].texture = textPoint2
        
    }
    //通过索引获取位置
    func onGetPosition(index:Int)->CGPoint{
        return CGPointMake( arrPoint[index].position.x,arrPoint[index].position.y)
    }
    
    //重置路点状态和步骤
    func onResetStep (){
        //清空arrNext数组
        arrNext = [Int]()
        //重置isFind
        isFind = false
        //计算消耗归零
        stepNum = 0
        //初始化所有的点
        for p in arrPoint {
            p.step = 99
            p.prePointIndex = -1
            p.onSetLabel("")
        }
    }
    //响应警告框消失后的方法，用于重置游戏
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        //将猫放回原处
        cat.position = onGetPosition(startIndex)
        //重置所有的点
        for p in arrPoint {
            //都设为灰点
            p.type = PointType.gray
            p.texture = textPoint1
        }
        //重置猫的位置索引
        currIndex = startIndex
        //随机生成红色点
        onCreateRed()
        //重置寻路产生的数据变化
        onResetStep()
    }
}