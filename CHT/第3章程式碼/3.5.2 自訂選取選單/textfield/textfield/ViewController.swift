

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        //建立三個選單的選項
        let mail = UIMenuItem(title: "信件", action: "onMail")
        let weixin = UIMenuItem(title: "微信", action: "onWeiXin")
        let weibo = UIMenuItem(title: "微網誌", action: "onWeiBo")
        //案例化 UIMenuController
        let menu = UIMenuController()
        //將選單選項賦予menu
        menu.menuItems = NSArray(array: [mail,weixin,weibo]) as? [UIMenuItem] 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 響應信件的點擊
    func onMail(){
        print("mail")
    }
    //響應微信的點擊
    func onWeiXin(){
        print("weixin")
    }
    //響應微網誌的點擊
    func onWeiBo(){
        print("weibo")
    }
}

