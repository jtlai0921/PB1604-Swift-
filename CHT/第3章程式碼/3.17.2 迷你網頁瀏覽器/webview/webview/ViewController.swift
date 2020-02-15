

import UIKit

class ViewController: UIViewController {
    //關聯兩個控制項
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var lbUrl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onGoToWeb(sender: AnyObject) {
        /**
         Xcode7不支援http通訊，需要在plist增加一個字段以支援http 1.在Info.plist中加入NSAppTransportSecurity型態Dictionary。 2.在NSAppTransportSecurity下加入NSAllowsArbitraryLoads型態Boolean,值設為YES 

        */
        
        
        let url = NSURL(string: lbUrl.text!)
        let urlRequest = NSURLRequest(URL: url!)
        //載入url
        webView.loadRequest(urlRequest)
    }

}

