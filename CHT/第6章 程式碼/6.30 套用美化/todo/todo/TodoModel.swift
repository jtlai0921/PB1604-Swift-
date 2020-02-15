import UIKit

class TodoModel: NSObject {
    //記錄工作分類別的資料
    var typeList = [TypeItem]()
    //建構方法
    override init(){
        super.init()
        print("沙盒資料夾路徑：\(documentsDirectory())")
        print("資料檔路徑：\(dataFilePath())")
        //起始化類比資料
//        onCreateData()
        loadData()
    }
    //建立類比資料
    func onCreateData(){
        for i in 1...10{
            let name = "工作分類別：\(i)"
            let type = TypeItem(name: name)
            for j in 0...4 {
                let todo = TodoItem(text: "工作清單：\(j)", checked: false, dueDate: NSDate(), shouldRemind: true, level: 0)
                type.items.append(todo)
            }
            typeList.append(type)
        }
    }
    //增加分類別的方法
    func onAddType(type:TypeItem){
        typeList.append(type)
    }
    
    //獲得itemid
    class func nextTodoItemId()->Int{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        //取得ChecklistItemId值
        let itemId = userDefaults.integerForKey("todoItemId")
        //+1後儲存ChecklistItemId值
        userDefaults.setInteger(itemId+1, forKey: "todoItemId")
        //強制要求userDefaults立即儲存
        userDefaults.synchronize()
        return itemId
    }
    
    //取得沙盒資料夾路徑
    func documentsDirectory()->String {
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        var documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    //取得資料檔位址
    func dataFilePath ()->String{
        return self.documentsDirectory().stringByAppendingString("todo.plist")
    }
    //儲存資料
    func saveData(){
        let data = NSMutableData()
        //申明一個歸檔處理物件
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        //將lists以對應Checklist關鍵字進行解碼
        archiver.encodeObject( typeList, forKey: "todolist")
        //解碼結束
        archiver.finishEncoding()
        //資料寫入
        data.writeToFile(dataFilePath(), atomically: true)
    }
    //讀取資料
    func loadData(){
        //取得本機資料檔位址
        let path = self.dataFilePath()
        //宣告檔案管理器
        let defaultManager = NSFileManager()
        //透過檔案位址判斷資料檔是否存在
        if defaultManager.fileExistsAtPath(path) {
            //讀取檔案資料
            let data = NSData(contentsOfFile: path)
            //解碼器
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            //透過歸檔時設定的關鍵字Checklist復原lists
            typeList = unarchiver.decodeObjectForKey("todolist") as! Array
            //結束解碼
            unarchiver.finishDecoding()
        }else{
            //若果檔案不存在，則是第一次安裝該套用，建立一個checklist
            var type = TypeItem(name: "女神有關")
            typeList.append(type)
            saveData()
        }
    }
    //對lists進行排序
    func sortLists(){
        typeList.sortInPlace(onSort)
    }
    //字元比較排序法
    func onSort(s1:TypeItem,s2:TypeItem)->Bool{
        return s1.name > s2.name
    }

}
//建立全局資料
var todoModel = TodoModel()