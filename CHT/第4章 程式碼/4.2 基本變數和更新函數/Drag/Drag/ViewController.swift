

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
        onUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //拖曳條value changed 事件關聯函數
    @IBAction func sliderChange(sender: AnyObject) {

        
    }
    //點擊按鈕的 Touch Up Inside 事件的關聯函數
    @IBAction func onAlert(sender: AnyObject) {
        
    }

    //重頭再來 按鈕的 Touch Up Inside 事件的關聯函數
    @IBAction func reSet(sender: AnyObject) {

    }
    //跳躍到得分規則按鈕的 Touch Up Inside 事件的關聯函數
    @IBAction func onShowInfo(sender: AnyObject) {
        
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


}

