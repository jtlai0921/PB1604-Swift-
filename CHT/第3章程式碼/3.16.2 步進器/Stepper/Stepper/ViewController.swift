
import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var sp1: UIStepper!
    @IBOutlet weak var sp2: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        onUpdate()
        // 只顯示圖片非透明區域的輪廓
        sp2.setDecrementImage(UIImage(named: "sub.png"), forState: UIControlState.Normal)
        sp2.setIncrementImage(UIImage(named: "add.png"), forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onChange(sender: AnyObject) {
        onUpdate()
    }
    func onUpdate(){
        lb1.text="攻擊力：\(sp1.value)"
        lb2.text="防御力：\(sp2.value)"
    }

}

