

import UIKit

class ViewController: UIViewController {
    //目的滑動區塊
    @IBOutlet weak var sliderTarget: UISlider!
    
    //動作滑動區塊
    @IBOutlet weak var mySlider: UISlider!
    //分數
    @IBOutlet weak var labScore: UILabel!
    //回合數
    @IBOutlet weak var labRound: UILabel!
    
    //目的數字
    var tarValue :Int = 0
    //拖到的數字
    var currValue :Int = 0
    //總分數
    var theScore :Int32 = 0
    //總回合數
    var theRound = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //自訂滑動區塊外觀函數
        onCreateSlider()
        //第一次執行時產生目的值並更新labels
        onUpdate();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //拖曳條value changed 事件關聯函數
    @IBAction func sliderChange(sender: AnyObject) {
        //將滑動區塊值取整，
        currValue = lroundf(mySlider!.value)
        
    }
    //點擊按鈕的 Touch Up Inside 事件的關聯函數
    @IBAction func onAlert(sender: AnyObject) {
        //目的值與滑動區塊值的差
        var diff :Int = currValue - tarValue
        //若果差值為負，轉正
        if diff < 0 {
            diff *= -1
        }
        //用100減去差值就是得分。
        let score = 100 - diff
        //將得分計入總分
        theScore += score
        var message:String
        switch(score){
        //滿分訊息
        case 100:
            message = "太牛逼了，大俠的得分是：\(score)"
        //90至99分訊息
        case 90..<100:
            message = "大俠的得分是：\(score)"
        //80至89分訊息
        case 80..<90:
            message = "大俠,您的眼力還差點，得分是：\(score)"
        default:
            message = "您的眼力差的有點離譜了，只有 \(score) 分"
            
        }
        let alert = UIAlertView(title: "老鎮帥不帥", message: message, delegate: self, cancelButtonTitle: "帥")
        alert.show()
    }
    //當警示框消失時響應的函數
    func alertView(alertView: UIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        onUpdate()
        
    }
    //重頭再來 按鈕的 Touch Up Inside 事件的關聯函數
    @IBAction func reSet(sender: AnyObject) {
        //將目前值設為50
        currValue = 50
        //回合數和總分數設為0
        theRound = 0
        theScore = 0
        //更新標簽的值並開啟新的游戲回合
        onUpdate()
    }
    //跳躍到得分規則按鈕的 Touch Up Inside 事件的關聯函數
    @IBAction func onShowInfo(sender: AnyObject) {
        //案例化一個得分規則界面
        let controller = InfoViewController (nibName: "InfoViewController", bundle: nil)
        //規則界面出現的動畫模式
        controller.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        //界面跳躍
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    //界面顯示更新函數
    func onUpdate(){
        //目的值
        tarValue = Int(1 + arc4random()%100)
        //給界面上的目的滑動區塊給予值
        sliderTarget!.value = Float(tarValue)
        //給總分label給予值
        labScore!.text = String(self.theScore)
        //回合數+1
        theRound++
        //給總回合數label給予值
        labRound!.text = String(self.theRound)
        //重設滑動區塊的值
        mySlider!.value = 50
    }
    //自訂滑動區塊外觀函數
    func onCreateSlider(){
        //設定滑動區塊的圖片
        let imgThumNormal = UIImage(named: "SliderThumb-Normal")
        self.mySlider!.setThumbImage(imgThumNormal, forState: UIControlState.Normal)
        self.sliderTarget!.setThumbImage(imgThumNormal, forState: UIControlState.Normal)
        
        //設定滑動區塊反白的圖片
        let imgThumbHighlighter = UIImage(named: "SliderThumb-Highlighted")
        self.mySlider!.setThumbImage(imgThumbHighlighter, forState: UIControlState.Highlighted)
        self.sliderTarget!.setThumbImage(imgThumbHighlighter, forState: UIControlState.Highlighted)
        
        //設定滑動區塊左邊的軌道圖片
        let imgTrackLeft = UIImage(named: "SliderTrackLeft")
        //將圖片設定為三宮縮放形式，也就是從左開始14像素，從右開始14像素不變形，中間部分伸展
        let imgLeft = imgTrackLeft!.stretchableImageWithLeftCapWidth(14, topCapHeight: 0)
        self.mySlider!.setMinimumTrackImage(imgLeft, forState: UIControlState.Normal)
        self.sliderTarget!.setMinimumTrackImage(imgLeft, forState: UIControlState.Normal)
        
        //設定滑動區塊右邊軌道圖片
        let imgTrackRight = UIImage(named: "SliderTrackRight")
        //將圖片設定為三宮縮放形式，也就是從左開始14像素，從右開始14像素不變形，中間部分伸展
        let imgRight = imgTrackRight!.stretchableImageWithLeftCapWidth(14, topCapHeight: 0)
        self.mySlider!.setMaximumTrackImage(imgRight, forState: UIControlState.Normal)
        self.sliderTarget!.setMaximumTrackImage(imgRight, forState: UIControlState.Normal)
    }

}

