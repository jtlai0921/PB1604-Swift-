import UIKit

class TypeItem: NSObject {
    //工作分類別的名稱
    var name:String = ""
    //分類別圖標
    var icon:String = "提醒"
    //工作清單資料
    var items = [TodoItem]()
    //建構方法
    init(name:String){
        super.init()
        self.name = name
    }
    //從nsobject解析回來
    init(coder aDecoder:NSCoder!){
        self.name=aDecoder.decodeObjectForKey("Name") as! String
        self.items=aDecoder.decodeObjectForKey("Items") as! [TodoItem]
        self.icon=aDecoder.decodeObjectForKey("Icon") as! String
    }
    //解碼成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(name,forKey:"Name")
        aCoder.encodeObject(items,forKey:"Items")
        aCoder.encodeObject(icon,forKey:"Icon")
    }
    //計算該類別工作 還有多少item沒有選取，也就是還沒辦需要提醒
    func countUncheckedItems()->Int{
        var count = 0
        for item in items {
            if item.checked != true {
                count++
            }
        }
        return count
    }
}
