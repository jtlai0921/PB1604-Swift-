import UIKit

class ViewController: UIViewController {
    //ImageView控制項 歌曲封面
    @IBOutlet weak var iv: UIImageView!
    //TableView控制項 歌曲清單
    @IBOutlet weak var tv: UITableView!
    //ProgressView控制項 播放進度指示器
    @IBOutlet weak var progressView: UIProgressView!
    //Label控制項 播放時間
    @IBOutlet weak var playTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

