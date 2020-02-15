import UIKit

class ViewController: UIViewController {
    //關聯Label
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //關聯點擊函數
    @IBAction func onClick(sender: AnyObject) {
        let item = sender as! UIBarItem
        //輸出被點擊的Bar Button Item 的tag屬性。
        label.text = "點擊了 Tag為：\(item.tag) 的按鈕"
    }


}

