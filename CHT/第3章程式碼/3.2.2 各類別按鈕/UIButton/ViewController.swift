
import UIKit

class ViewController: UIViewController {
    
    //關聯第一個按鈕
    @IBOutlet weak var btn1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定第一個按鈕的文字陰影的透明度
        btn1.layer.shadowOpacity = 0.3
        //設定第一個按鈕的文字陰影的模糊擴散的半徑
        btn1.layer.shadowRadius = 1
        //設定第一個按鈕的文字陰影的便宜方向和距離
        btn1.layer.shadowOffset = CGSizeMake(2,2)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //關聯第一個按鈕的點擊響應
    @IBAction func onClick(sender: AnyObject) {
        print("我被點中了……")
        //輸出我被點中了……
    }
}

