

import UIKit

class ViewController: UIViewController {
    //關聯日期選取器和文字框
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 日期選取器value changed事件的響應函數
    @IBAction func onChangeDate(sender: AnyObject) {
        let date = datePicker.date
        let dateFormat = NSDateFormatter()
        //日期的顯示格式
        dateFormat.dateFormat = "YYYY年MM月dd日 HH:mm"
        //將日期選取器的值給予值給label
        label.text = "日期："+dateFormat.stringFromDate(date)
    }

}

