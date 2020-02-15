import UIKit

class TodoListController: UITableViewController , ProtocolTodoDetail{
    //tableView的資料
    var todolist:TypeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定標題
        self.title = self.todolist?.name
    }
    //設定資料的行數
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todolist!.items.count
    }
    //設定table的單元格
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //取得cell對應的資料
        let item = todolist!.items[indexPath.row]
        //取得cell
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath) as UITableViewCell
        //取得label
        let label = cell.viewWithTag(1000) as! UILabel
        //設定label內容。
        label.text = item.text+" (\(LevelItem.onGetTitle(item.level)))"
        //設定cell的選取狀態
        onCheckmark(cell, item:item)
        return cell
    }
    //設定check選取
    func onCheckmark(cell:UITableViewCell,item:TodoItem){
        //根據Tag取得cell中的checkbox
        var check = cell.viewWithTag(1002) as! UIImageView
        //透過item中的checked屬性來控制勾號是否顯示
        if item.checked {
            check.image = UIImage(named:"checkbox-checked")
        }else{
            check.image = UIImage(named:"checkbox-normal")
        }
        todoModel.saveData()
    }
    
    //點擊cell的響應方法
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //獲得row資料
        let item = todolist!.items[indexPath.row]
        //check屬性取反
        item.onChangeChecked()
        // 設定cell的選取框
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        onCheckmark(cell!, item:item)
        //取消勾選狀態
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //滑動移除
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //移除資料
        todolist!.items.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        //知會檢視移除的資料，同時顯示移除動畫
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        todoModel.saveData()
    }
    //改變滑動移除顯示的移除文字
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "移除"
    }
    //界面跳躍時
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //透過segue獲得導覽控制器
        let navigationController = segue.destinationViewController as! UINavigationController
        //透過導覽控制器的topViewController屬性獲得跳躍目的
        let controller = navigationController.topViewController as! TodoDetailController
        //設定代理
        controller.delegate = self
        //獲得標誌
        let segueStr = "\(segue.identifier!)"
        if segueStr == "AddItem" {
            
            controller.isAdd = true
        }else if segueStr == "EditItem" {
            //取得indexPath
            let indexPath = self.tableView.indexPathForCell(sender! as! UITableViewCell)
            //將要編輯的Model傳給新界面
            controller.todoItem = todolist!.items[indexPath!.row]
            controller.isAdd = false
            
        }
    }
    
    //響應ProcotolTodoDetail協定需要實現的兩個方法
    func addItem(item:TodoItem){
        todolist?.items.append(item)
    }
    func editItem(){
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
