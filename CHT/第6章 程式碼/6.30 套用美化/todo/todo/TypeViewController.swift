import UIKit

class TypeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //顯示檢視的時候重新載入資料
    override func viewWillAppear(animated: Bool) {
        //重新載入資料
        self.tableView.reloadData()
    }

    //設定tableview的行數
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //傳回資料條數
        return todoModel.typeList.count
    }
    //設定cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //取得行對應的資料
        let typeItem = todoModel.typeList[indexPath.row]
        //為cell設定Identifier
        let cellIdentifier = "typeCell"
        //依據Identifier建立Cell
        let cell=UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        //設定cell的標題
        cell.textLabel!.text = typeItem.name
        //設定cell的縮圖
        cell.imageView!.image = UIImage(named:typeItem.icon)
        
        
        //傳回有多少個工作代辦需要提醒
        let count = typeItem.countUncheckedItems()
        //根據不同的情況顯示不同的副標題
        if typeItem.items.count == 0{
            //若果還沒有加入工作
            cell.detailTextLabel?.text = "還沒有加入工作"
        }else{
            if count == 0 {
                cell.detailTextLabel?.text = "全部搞定"
            }else{
                cell.detailTextLabel?.text = "還有 \(count) 個工作要完成"
            }
        }
        
        
        return cell
    }
    
    //原滑動移除方法，需保留
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    //滑動移除與編輯
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "編輯") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            //取得勾選行的資料
            var typeItem = todoModel.typeList[indexPath.row]
            
            //取得加入檢視的導覽控制器
            let navigation = self.tabBarController?.viewControllers?[1] as! UINavigationController
            //取得“加入”檢視
            let typeDetail = navigation.viewControllers.first as? TypeDetailViewController
            typeDetail?.onEditType(typeItem)
            //檢視跳躍
            self.tabBarController?.selectedIndex = 1
        }
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "移除") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            //移除資料
            todoModel.typeList.removeAtIndex(indexPath.row)
            //移除資料的位置標誌陣列
            let indexPaths = [indexPath]
            //知會檢視移除的資料，同時顯示移除動畫
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
            todoModel.saveData()
        }
        //設定背景彩色
        editAction.backgroundColor = UIColor.lightGrayColor()//亮灰色
        deleteAction.backgroundColor = UIColor.redColor()//紅色
        return [deleteAction,editAction]
    }
   
    //cell點擊跳躍
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取得勾選行的資料
        let type = todoModel.typeList[indexPath.row]
        //可以將任何東西放入sender,對應prepareForSegue中的sender
        self.performSegueWithIdentifier("showTodoList", sender: type)
        
    }

    //segue切換，傳參
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        //取得導覽控制器
        let navigationController = segue.destinationViewController as! UINavigationController
        //取得切換目的
        let controller = navigationController.topViewController as! TodoListController
        //給目的傳參數
        controller.todolist = sender as? TypeItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

