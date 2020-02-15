/*

switch 的屬性 on代表著switch開關的屬性

*/

import UIKit

class ViewController: UIViewController {
    //關聯TextView
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //關聯Switch的ValueChanged事件
    @IBAction func onChange(sender: AnyObject) {
        textView.editable = (sender as! UISwitch).on
    }

}

