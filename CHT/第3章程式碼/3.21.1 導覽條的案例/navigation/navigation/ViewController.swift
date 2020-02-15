

import UIKit

class ViewController: UIViewController {
    //記錄導覽項的數量
    var count = 0
    //宣告導覽條
    var navigationBar:UINavigationBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        //案例化導覽條
        navigationBar = UINavigationBar(frame: CGRectMake(0, 20, 320, 44))
        //加入到ViewController的view中
        self.view.addSubview(navigationBar!)
        onAdd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //增加導覽項函數
    func onAdd(){
        //增加導覽項數量
        count++
        //給導覽條增加導覽項
        navigationBar?.pushNavigationItem(onMakeNavitem(), animated: true)
        
    }
    //移除導覽項函數
    func onRemove(){
        if count > 1 {
            //減少導覽項的數量
            count--
            //從導覽條中移除最後一個導覽項
            navigationBar?.popNavigationItemAnimated(true)
        }
        
    }
    func onMakeNavitem()->UINavigationItem{
        //建立一個導覽項
        let navigationItem = UINavigationItem()
        //建立左邊按鈕
        let leftBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "onAdd")
        //建立右邊按鈕
        let rightBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "onRemove")
        //設定導覽欄的標題
        navigationItem.title = "第 \(count) 個導覽項"
        //設定導覽項左邊的按鈕
        navigationItem.setLeftBarButtonItem(leftBtn, animated: true)
        //設定導覽項右邊的按鈕
        navigationItem.setRightBarButtonItem(rightBTN, animated: true)
        
        return navigationItem
    }

}

