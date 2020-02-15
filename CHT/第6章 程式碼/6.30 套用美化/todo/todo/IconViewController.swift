import UIKit

class IconViewController: UITableViewController {
    //協定代理
    var delegate:ProtocolIconView?
    var icons = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "選取圖示"
        //所有的圖示名稱
        icons.append("No Icon")
        icons.append("分享")
        icons.append("貨運")
        icons.append("記錄")
        icons.append("旅行")
        icons.append("提醒")
        icons.append("天氣")
        icons.append("衛生")
        icons.append("檔案")
        icons.append("心情")
        
    }
    //傳回資料行數
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    //設定cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //取得cell
        let cell = tableView.dequeueReusableCellWithIdentifier("iconCell")! as UITableViewCell
        //取得圖示名稱
        let icon = icons[indexPath.row]
        //設定標題為圖示名稱
        cell.textLabel!.text = icon
        //根據圖示名稱設定縮圖
        cell.imageView!.image = UIImage(named: icon)
        return cell
    }
    //選取圖示後
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取得圖示name
        let iconName = icons[indexPath.row]
        self.delegate?.iconPicker(didPickIcon: iconName)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
//用於回調選取了圖示的方法
protocol ProtocolIconView{
    func iconPicker( didPickIcon iconName:String)
}