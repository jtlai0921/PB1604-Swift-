/*
分段控制器案例：文字框顯示分段控制器選取的標題
動態增加和移除分段控制器的內容
*/

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var tv: UITextView!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var segmented: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        //顯示分段控制器預設選取的標題
        onChanged(segmented)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //動態增加分段標題的函數
    @IBAction func onAdd(sender: AnyObject) {
        let count2 = segmented.numberOfSegments
        let title = tf.text
        if title!.characters.count > 0 {
            segmented.insertSegmentWithTitle(title, atIndex: count2, animated: true)
        }
    }
    //動態移除分段標題的函數
    @IBAction func onDelete(sender: AnyObject) {
        let index = segmented.numberOfSegments - 1
        if index > 0 {
            segmented.removeSegmentAtIndex(index, animated: true)
        }
        
    }
    //分段控制器選取函數
    @IBAction func onChanged(sender: AnyObject) {
        let index = segmented.selectedSegmentIndex
        let title = segmented.titleForSegmentAtIndex(index)!
        tv.text = "勾選了第 \(index + 1) 個分段，標題是:\(title)"
    }


}

