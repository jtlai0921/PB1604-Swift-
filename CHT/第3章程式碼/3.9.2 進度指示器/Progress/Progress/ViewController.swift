import UIKit

class ViewController: UIViewController  {
    //關聯進度指示器
    @IBOutlet weak var progress: UIProgressView!
    //時間控制器
    var timer : NSTimer?
    //進度值
    var progressValue : Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        onSetProgressValue()
        //案例化時間控制器，參數為：時間間隔，傳送的物件，間隔響應函數名，傳遞的參數，是否重復
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //時間間隔響應的函數
    func onTimer(){
        progressValue += 0.02
        //進度指示器走滿的時候重新回到起點
        if progressValue >= 1{
            progressValue = 0.0
        }
        onSetProgressValue()
    }
    func onSetProgressValue(){
        progress.progress = progressValue
    }

}

