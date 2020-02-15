import UIKit

class ChannelController: UIViewController {
    //TableView控制項 頻道清單
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "channel")
        cell.textLabel!.text = "title:\(indexPath.row)"
        cell.detailTextLabel?.text = "detail:\(indexPath.row)"
        return cell
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        print("選取了第\(indexPath.row)行")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
