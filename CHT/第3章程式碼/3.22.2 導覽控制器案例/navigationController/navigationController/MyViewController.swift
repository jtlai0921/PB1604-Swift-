

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //關聯按鈕的“Touch Up Inside”事件
    @IBAction func onGotoView1(sender: AnyObject) {
        //傳回根檢視
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
