import UIKit

protocol ChannelProtocol{
    func onChangeChannel(channel_id:String)
}

class ChannelController: UIViewController {
    //TableView控制項 頻道清單
    @IBOutlet weak var tv: UITableView!
    //頻道清單資料
    var channelData:NSArray=NSArray()
    //遵循ChannelProtocol協定的代理
    var delegate:ChannelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //tableview的行數
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return channelData.count
    }
    //設定cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "channel")
        //取得到勾選的行的資料
        let rowData:NSDictionary=self.channelData[indexPath.row] as! NSDictionary
        //設定tableView的標題
        cell.textLabel!.text = rowData["name"] as? String
        return cell
    }
    //勾選了實際的頻道
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let rowData:NSDictionary=self.channelData[indexPath.row] as! NSDictionary
        //取得選取的頻道id
        let channel_id:AnyObject? = rowData["channel_id"] 
        //將AnyObject轉為String
        let channel:String="channel=\(channel_id!)"
        //將頻道id傳回給主界面
        delegate?.onChangeChannel(channel)
        //關閉目前界面
        self.dismissViewControllerAnimated(true, completion: nil)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
