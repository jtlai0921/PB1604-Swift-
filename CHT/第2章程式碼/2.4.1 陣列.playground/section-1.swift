//建立一個都是字串的空陣列
var 我是空陣列:[String] = [String]()
//建立一個儲存了字串的陣列
var 我最喜歡的漫畫 = ["火影忍者","海賊王","死神"]


//透過索引來存取陣列中的資料
print("我最喜歡的漫畫是：\(我最喜歡的漫畫[0])")
//透過索引修改陣列中的資料
我最喜歡的漫畫[0] = "七龍珠"
print("我最喜歡的漫畫是：\(我最喜歡的漫畫[0])")


//給陣列加入資料
我最喜歡的漫畫.append("進擊的巨人")
我最喜歡的漫畫

//透過索引來改變一群組資料,我們將前3個元素置換成了“獵人”
我最喜歡的漫畫[0...2] = ["獵人"]
我最喜歡的漫畫

//insert方法
我最喜歡的漫畫.insert("城市獵人", atIndex: 1)
我最喜歡的漫畫

//removeAtIndex
我最喜歡的漫畫.removeAtIndex(1)
我最喜歡的漫畫

//removeLast
我最喜歡的漫畫.removeLast()
我最喜歡的漫畫

//取得陣列資料數
我最喜歡的漫畫.count

//復原陣列
我最喜歡的漫畫 = ["火影忍者","海賊王","死神"]

//使用for in 檢查陣列
for 漫畫 in 我最喜歡的漫畫 {
    print("\(漫畫)")
}

//enumerate來檢查索引與資料
for (索引,資料) in 我最喜歡的漫畫.enumerate() {
    print("\(索引)：\(資料)")
}

