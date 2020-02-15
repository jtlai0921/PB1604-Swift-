

import UIKit

class PV2Controller: UIViewController,UIPickerViewDelegate{
    //d1為pv2第一列的資料源，d2為pv2第二列的資料源
    var d1 = ["海賊王","死神","獵人","火影忍者"]
    var d2 = ["尾田榮一郎","久保帶人","坑爹義博","岸本齊史"]
    var str1 = ""
    var str2 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //UIPickerViewDataSource 需要實現如下2個方法
    // 控制項包括幾列
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 2
    }
    //傳回UIPickerView有多少行資料
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        // 傳回第一列的資料行數
        if component == 0{
            return d1.count
        }
        // 傳回第二列資料行數
        return d2.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //component等於0時為第一列，1為第二列。
        if component == 0{
            return d1[row]
        }
        return d2[row]
    }
    //響應選取器勾選後的函數
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            str1 = d1[row]
        }else{
            
            str2 = d2[row]
        }
        print("我最喜歡的漫畫是:\(str1) , 我最喜歡的漫畫家是: \(str2)")
    }
    
    
}

