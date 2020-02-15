
import UIKit

class ViewController: UIViewController,UIPickerViewDelegate{
    //關聯兩個選取器
    @IBOutlet weak var pv1: UIPickerView!
    @IBOutlet weak var pv2: UIPickerView!
    
    //設定pv1的資料源
    var d1 = ["海賊王","死神","獵人","火影忍者"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pv1.delegate = self
        
        let pv2Controller = PV2Controller()
        self.addChildViewController(pv2Controller)
        pv2.delegate = pv2Controller
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //UIPickerViewDataSource 需要實現如下2個方法
    // 元件包括幾列
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    //傳回UIPickerView有多少航資料
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        
        return d1.count
    }
    // 顯示標題
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return d1[row]
    }
    // 響應選取器
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        print("我最喜歡的漫畫是:\(d1[row])")
    }

}

