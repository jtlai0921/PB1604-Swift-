import UIKit

class TodoLevelController: UITableViewController {
    //資料源
    var arrLevel:[LevelItem] = [LevelItem]()
    //代理
    var delegate:ProtocolLevel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "選取工作的重要等級"
        
    }
    //建立資料並設定選取的項
    func onSetCheckMark(level:Int){
        for i in 0...4 {
            let item = LevelItem(level: i)
            if i == level{
                item.checkMark = true
            }
            arrLevel.append(item)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //設定table的行數
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLevel.count
    }
    
    
    //設定table的單元格
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //取得cell對應的資料
        let item = arrLevel[indexPath.row]
        //取得cell
        let cell = tableView.dequeueReusableCellWithIdentifier("levelCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = item.title
        if item.checkMark {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    //選取單元格
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = arrLevel[indexPath.row]
        delegate?.onGetLevel(item)
    }
    
    
}

protocol ProtocolLevel{
    func onGetLevel(levelItem:LevelItem)
}
