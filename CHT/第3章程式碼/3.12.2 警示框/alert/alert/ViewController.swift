

import UIKit

class ViewController: UIViewController,UIAlertViewDelegate {
    var type = 0
    var alert:UIAlertView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 響應普通按鈕點擊
    @IBAction func onShowAlert(sender: AnyObject) {
        onMackAlert(0)
    }
    // 響應輸入框按鈕點擊
    @IBAction func onShowInputAlert(sender: AnyObject) {
        onMackAlert(1)
    }
    // 響應密碼框按鈕點擊
    @IBAction func onShowPassAlert(sender: AnyObject) {
        onMackAlert(2)
    }
    // 響套用戶登入按鈕點擊
    @IBAction func onShowLoginAlert(sender: AnyObject) {
         onMackAlert(3)
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch type {
        case 0:
            print("點擊了第 \(buttonIndex) 個按鈕")
        case 1:
            let input = alert?.textFieldAtIndex(0)
            print("你寫下了： \(input!.text) ")
        case 2:
            let pass = alert?.textFieldAtIndex(0)
            print("嘿嘿，你的密碼是： \(pass!.text) ")
        case 3:
            let name = alert?.textFieldAtIndex(0)
            let password = alert?.textFieldAtIndex(0)
            print("你的使用者名稱是： \(name!.text)  密碼是：\(password!.text)")
        default:
             print("點擊了第 \(buttonIndex) 個按鈕")
        }
       
    }
    func onMackAlert(type:Int){
        //記錄警示框類別別
        self.type = type
        switch type {
        case 0:
            
            alert = UIAlertView(title: "普通警示框", message: "黑門，我是一個警示框！", delegate: self, cancelButtonTitle: "我是確定按鈕", otherButtonTitles: "知道了- -", "藥藥，切克鬧")
            alert!.alertViewStyle = UIAlertViewStyle.Default
        case 1 :
            
            alert = UIAlertView(title: "帶輸入框的警示框", message: "黑門，寫點什麼吧！", delegate: self, cancelButtonTitle: "我是確定按鈕")
            alert!.alertViewStyle = UIAlertViewStyle.PlainTextInput
        case 2 :
            
            alert = UIAlertView(title: "帶密碼框的警示框", message: "黑門，不要告訴別人你寫什麼哦！", delegate: self, cancelButtonTitle: "我是確定按鈕")
            alert!.alertViewStyle = UIAlertViewStyle.SecureTextInput
        case 3 :
            
            alert = UIAlertView(title: "使用者登入的警示框", message: "黑門，輸入你的使用者名稱和密碼吧", delegate: self, cancelButtonTitle: "我是確定按鈕")
            alert!.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
        default :
            alert!.alertViewStyle = UIAlertViewStyle.Default
        }
        //顯示警示框
        alert!.show()
    }
}

