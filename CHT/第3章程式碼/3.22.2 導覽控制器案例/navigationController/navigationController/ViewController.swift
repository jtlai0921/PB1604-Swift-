import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //關聯按鈕的“Touch Up Inside”事件
    @IBAction func onGotoView2(sender: AnyObject) {
        //透過storyboard id取得檢視2
        let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("view2") as! MyViewController
        self.navigationController?.pushViewController(view2, animated: true)
    }

}

