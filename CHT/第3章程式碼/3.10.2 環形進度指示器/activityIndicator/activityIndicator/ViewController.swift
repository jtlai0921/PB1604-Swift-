import UIKit

class ViewController: UIViewController {
    //關聯三個環形進度指示器
    @IBOutlet weak var ai3: UIActivityIndicatorView!
    @IBOutlet weak var ai2: UIActivityIndicatorView!
    @IBOutlet weak var ai1: UIActivityIndicatorView!
    var arrAI = [UIActivityIndicatorView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //將所有的activity indicator view 放入陣列
        arrAI.append(ai1)
        arrAI.append(ai2)
        arrAI.append(ai3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onStart(sender: AnyObject) {
        onSetAI(true)
    }

    @IBAction func onStop(sender: AnyObject) {
        onSetAI(false)
    }
    //控制 activity indicator view 的動畫播放
    func onSetAI(isStart:Bool){
        for ai in arrAI {
            if isStart {
                //進度指示器開始轉動
                ai.startAnimating()
            }else {
                //進度指示器停止轉動
                ai.stopAnimating()
            }
            
        }
    }
}

