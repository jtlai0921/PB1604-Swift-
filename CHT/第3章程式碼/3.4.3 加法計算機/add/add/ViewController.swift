
import UIKit

class ViewController: UIViewController {
    // 關聯三個文字框
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onExit(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    //計算按鈕的Touch Up Inside事件響應方法
    @IBAction func onAdd(sender: AnyObject) {
        //將文字框的值轉為NSString型態，然後再轉為浮點型態，才能進行加法計算
        let add = (tf1.text! as NSString).floatValue + (tf2.text! as NSString).floatValue
        //將計算結果以保留小數點2位數的形式轉為字串型態
        let str = String(format: "%.2f", add)
        //最後將結果值設定給tf3文字框
        tf3.text = str
    }
    //點擊背景關閉虛擬鍵碟
    @IBAction func onClick(sender: AnyObject) {
        tf1.resignFirstResponder()
        tf2.resignFirstResponder()
        tf3.resignFirstResponder()
    }

}

