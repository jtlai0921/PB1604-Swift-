import UIKit

class ViewController: UIViewController,HttpProtocol{
    //ImageView控制項 歌曲封面
    @IBOutlet weak var iv: UIImageView!
    //TableView控制項 歌曲清單
    @IBOutlet weak var tv: UITableView!
    //ProgressView控制項 播放進度指示器
    @IBOutlet weak var progressView: UIProgressView!
    //Label控制項 播放時間
    @IBOutlet weak var playTime: UILabel!
    
    //取得網路資料的類別
    var eHttp:HttpController = HttpController()
    //接收歌曲清單的陣列
    var tableData:NSArray=NSArray()
    //接收頻道清單的陣列
    var channelData:NSArray=NSArray()
    //透過圖片位址進行圖片快取的字典
    var imageCache=Dictionary<String,UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //為HttpController案例設定代理
        eHttp.delegate=self
        //取得頻道0的歌曲資料
        eHttp.onSearch("http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite")
    }
    //傳回資料的行數
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
    }
    //設定cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        //取得標示為“douban”的cell
        let cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "douban")
        //取得cell的資料
        let rowData:NSDictionary=self.tableData[indexPath.row] as! NSDictionary
        //設定標題
        cell.textLabel!.text = rowData["title"] as? String
        //設定詳情
        cell.detailTextLabel?.text = rowData["artist"] as? String
        //取得圖片位址
        let url=rowData["picture"] as! String
        //透過圖片位址去快取中取圖片
        let image = self.imageCache[url] 
        if image == nil { //若果快取中沒有
            //定義NSURL
            let imgURL:NSURL=NSURL(string:url)!
            //定義NSURLRequest
            let request:NSURLRequest=NSURLRequest(URL:imgURL)
            //異步取得圖片
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse?,data:NSData?,error:NSError?)->Void in
                //將圖片資料賦予UIImage
                let img=UIImage(data:data!)
                //設定縮圖
                cell.imageView!.image = img
                //將該圖片加入快取
                self.imageCache[url]=img
            })
        }else{//若果快取中有，直接抓取
            cell.imageView!.image=image
        }
        
        //傳回cell
        return cell
    }
    //選取資料行響應方法
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        print("選取了第\(indexPath.row)行")
        //取得勾選行的資料
        let rowData: NSDictionary = self.tableData[indexPath.row] as! NSDictionary
        //取得改行中的圖片位址
        let imgUrl:String=rowData["picture"] as! String
        //設定封面圖片
        onSetImage(imgUrl)
    }
    //實現HttpProtocol協定的方法
    func didRecieveResults(results:NSDictionary){
        //若果資料的song關鍵字不為nil
        if (results["song"] != nil) {
            //填充tableData
            self.tableData=results["song"] as! NSArray
            //更新tv的資料
            self.tv!.reloadData()
            
            //取得第一首歌的歌曲位址和縮圖位址
            let firDict:NSDictionary=self.tableData[0] as! NSDictionary
            let audioUrl:String=firDict["url"] as! String
            print("音樂位址：\(audioUrl)")
            let imgUrl:String=firDict["picture"] as! String
            print("圖片位址:\(imgUrl)")
            onSetImage(imgUrl);
            
        }
    }
    //設定歌曲的封面圖
    func onSetImage(url:String){
        let image = self.imageCache[url] 
        if image == nil{
            let imgURL:NSURL=NSURL(string:url)!
            let request:NSURLRequest=NSURLRequest(URL:imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse?,data:NSData?,error:NSError?)->Void in
                let img=UIImage(data:data!)
                self.iv!.image=img
                self.imageCache[url]=img
                
            })
        }else {
            self.iv!.image=image
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

