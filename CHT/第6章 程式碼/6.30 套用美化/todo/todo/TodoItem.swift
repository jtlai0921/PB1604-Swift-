import UIKit

class TodoItem: NSObject {
    //工作名稱
    var text:String
    //是否完成
    var checked:Bool
    //提醒時間
    var dueDate:NSDate
    //是否提醒
    var shouldRemind:Bool
    //工作id
    var itemId:Int
    //等級
    var level:Int = 0
    //建構方法
    init(text:String="",checked:Bool=false,dueDate:NSDate=NSDate(),shouldRemind:Bool=true,level:Int=0){
        self.text=text
        self.checked=checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemId = TodoModel.nextTodoItemId()
        self.level = level
        super.init()
    }
    //設定是否完成屬性
    func onChangeChecked(){
        self.checked = !self.checked
    }
    
    //從nsobject解析回來
    init(coder aDecoder:NSCoder!){
        self.text=aDecoder.decodeObjectForKey("Text") as! String
        self.checked=aDecoder.decodeObjectForKey("Checked") as! Bool
        self.dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        self.shouldRemind = aDecoder.decodeObjectForKey("ShouldRemind") as! Bool
        self.itemId = aDecoder.decodeObjectForKey("ItemId") as! Int
        self.level = aDecoder.decodeObjectForKey("level") as! Int
    }
    //解碼成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(text,forKey:"Text")
        aCoder.encodeObject(checked,forKey:"Checked")
        aCoder.encodeObject(dueDate,forKey:"DueDate")
        aCoder.encodeObject(shouldRemind,forKey:"ShouldRemind")
        aCoder.encodeObject(itemId,forKey:"ItemId")
        aCoder.encodeObject(level,forKey:"level")
    }
    //傳送知會訊息
    func scheduleNotification(){
        //透過itemID取得已有的訊息推送，然後移除掉，以便重新判斷
        let existingNotification = self.notificationForThisItem() as UILocalNotification?
        if existingNotification != nil {
            //若果existingNotification不為nil，就取消訊息推送
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
        
        //NSComparisonResult.OrderedAscending 表示儲存的dueDate比目前時間較早,即過期了
        //NSOrderedDescending 儲存的dueDate比目前時間晚
        //NSOrderedSame 儲存的dueDate與目前時間晚相同
        if self.shouldRemind && (self.dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending ) {
            //建立UILocalNotification來進行本機訊息知會
            let localNotification = UILocalNotification()
            //推送時間
            localNotification.fireDate = self.dueDate
            //時區
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            //推送內容
            localNotification.alertBody = self.text
            //音效
            localNotification.soundName = UILocalNotificationDefaultSoundName
            //額外訊息
            localNotification.userInfo = ["ItemID":self.itemId]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
        }
    }
    //透過檢查所有訊息推送，透過itemid的比較，傳回UIlocalNotification
    func notificationForThisItem()-> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! Dictionary<String,Int>
            let number = info["ItemID"]
            if number != nil && number == self.itemId {
                return notification as? UILocalNotification
            }
        }
        return nil
    }
    //解構
    deinit{
        //移除該工作的訊息推送，若果有的話
        let existingNotification = self.notificationForThisItem() as UILocalNotification?
        if existingNotification != nil {
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
}
