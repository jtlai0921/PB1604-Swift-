
import UIKit

class ViewController: UIViewController ,UIActionSheetDelegate {
    var alert:UIActionSheet?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //關聯按鈕的Touch Up Inside事件的函數
    @IBAction func onActionSheet(sender: AnyObject) {
        
        alert = UIActionSheet(title: "底部警示框", delegate: self, cancelButtonTitle: "取消按鈕（1）", destructiveButtonTitle: "確定按鈕（0）", otherButtonTitles:"我是一個按鈕（2）","我還是一個按鈕（3）")
        //顯示底部警示框
        alert?.showInView(self.view)
    }
    //響應按鈕的點擊函數
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print("點擊了第 \(buttonIndex) 個按鈕")
    }

}

