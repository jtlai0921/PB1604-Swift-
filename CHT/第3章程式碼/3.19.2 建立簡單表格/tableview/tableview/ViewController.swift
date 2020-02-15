

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var tb: UITableView!
    var arrTitle = ["海賊王","獵人","死神","火影忍者"]
    var arrAuthor = ["尾田榮一郎","坑爹義博","久保帶人","岸本齊史"]
    var arrImage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        arrImage.append(UIImage(named: "c1.jpg")!)
        arrImage.append(UIImage(named: "c2.jpg")!)
        arrImage.append(UIImage(named: "c3.jpg")!)
        arrImage.append(UIImage(named: "c4.jpg")!)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    //必須實現以下兩個方法
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        //傳回漫畫書名的數量作為表格的行數
        return arrTitle.count
    }
    //單元格設定
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        //單元格標題設為漫畫書名
        cell.textLabel!.text = arrTitle[index]
        //單元格詳細文字設為漫畫作者
        cell.detailTextLabel!.text = "作者："+arrAuthor[index]
        //單元格縮圖設為漫畫的縮圖
        cell.imageView!.image = arrImage[index]
        return cell
    }
    
    
    //cell選取後出現警示框
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let index = indexPath.row
        let title = arrTitle[index]
        let detail = "我喜歡的漫畫是："+title+"  作者是："+arrAuthor[index]
        let alert = UIAlertView(title: title, message: detail, delegate: self, cancelButtonTitle: "知道了")
        alert.show()
    }
    //滑動移除必須實現方法
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        print("移除\(indexPath.row)")
        let index = indexPath.row
        arrTitle.removeAtIndex(index)
        arrAuthor.removeAtIndex(index)
        arrImage.removeAtIndex(index)
        tb.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    //滑動移除
    func tableView(tableView: UITableView!, editingStyleForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    //修改移除按鈕的文字
    func tableView(tableView: UITableView!, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath!) -> String! {
        return "刪"
    }

}

