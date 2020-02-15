import UIKit

class ViewController: UIViewController{
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
    //傳回資料的行數
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    //設定cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        //取得標示為“douban”的cell
        let cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "douban")
        //設定標題
        cell.textLabel!.text = "title:\(indexPath.row)"
        //設定詳情
        cell.detailTextLabel?.text = "detail:\(indexPath.row)"
        //傳回cell
        return cell
    }
    //選取資料航響應方法
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        print("選取了第\(indexPath.row)行")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

