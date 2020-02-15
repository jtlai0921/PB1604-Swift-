
import UIKit

class ViewController: UIViewController {
    //關聯使用者名稱文字框
    @IBOutlet weak var userName: UITextField!
    //關聯密碼框
    @IBOutlet weak var passWord: UITextField!
    
    @IBAction func onFinishEdit(sender: AnyObject) {
        //關閉虛擬鍵碟
        sender.resignFirstResponder()
    }
    @IBAction func onCloseKeyBoard(sender: AnyObject) {
        //關閉因兩個文字框而產生的虛擬鍵碟
        self.userName.resignFirstResponder();
        self.passWord.resignFirstResponder();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

