
//建立一個空字典
var 我是一個空字典 = Dictionary<String,String>()
//建立一個有資料的字典
var 我是一個字典:Dictionary<String,String> = ["熱血漫畫":"海賊王","推理漫畫":"名偵探柯南","坑爹漫畫":"獵人"]
我是一個字典
//簡寫模式
var 漫畫 = ["熱血漫畫":"海賊王","推理漫畫":"名偵探柯南","坑爹漫畫":"獵人"]
漫畫

//透過索引來增加資料項
漫畫["經典漫畫"] = "七龍珠"
漫畫

//透過索引來讀取字典的值
漫畫["熱血漫畫"]

//透過下表來修改字典的值
漫畫["熱血漫畫"] = "火影忍者"

//移除某個key-value
漫畫["熱血漫畫"] = nil
漫畫

//透過removeValueForKey來移除
漫畫.removeValueForKey("坑爹漫畫")
漫畫

//檢查陣列
for (key,value) in 漫畫 {
    print("\(key):\(value)")
}

//檢查key
for key in 漫畫.keys{
    print("\(key)")
}
//輸出
//經典漫畫
//推理漫畫

//檢查value
for value in 漫畫.values{
    print("\(value)")
}
//輸出
//七龍珠
//名偵探柯南
