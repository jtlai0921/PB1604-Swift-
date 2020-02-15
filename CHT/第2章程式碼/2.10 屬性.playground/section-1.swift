//定義一個類別
class 女神類別 {
    lazy var 相貌 = "95分"
}
let 女神 = 女神類別()
女神.相貌

class 蘿莉類別{
    var 左眼視力 = 1.3
    var 右眼視力 = 1.4
    var 平均視力:Double{
        get {
            return (( 左眼視力 + 右眼視力 ) / 2)
        }
        set(新平均視力){
            左眼視力 = 新平均視力 - 0.1
            右眼視力 = 新平均視力 + 0.1
        }
    }
}
let 蘿莉 = 蘿莉類別 ()
蘿莉.平均視力
蘿莉.平均視力=1.4

//省略set 參數名
class 蘿莉2號類別{
    var 左眼視力 = 1.3
    var 右眼視力 = 1.4
    var 平均視力:Double{
        get {
            return (( 左眼視力 + 右眼視力 ) / 2)
        }
        set{
            左眼視力 = newValue - 0.1
            右眼視力 = newValue + 0.1
        }
    }
}
let 蘿莉2號 = 蘿莉2號類別 ()
蘿莉2號.平均視力
蘿莉2號.平均視力=1.4

//只讀屬性

class 蘿莉3號類別{
    var 左眼視力 = 1.3
    var 右眼視力 = 1.4
    var 平均視力:Double{
        return (( 左眼視力 + 右眼視力 ) / 2)
    }
}
let 蘿莉3號 = 蘿莉3號類別 ()
蘿莉3號.平均視力

//屬性監視器
class 正太類別 {
    var 身高 : Int = 130 {
        willSet{
            print("正太的身高將要變為：\(newValue)")
        }
        didSet{
            print("正太之前的身高為：\(oldValue)")
        }
    }
}

let 正太 = 正太類別 ()
正太.身高 = 135

//型態屬性

struct 某個結構體{
    static let 型態屬性 = 1024
}
enum 某個列舉{
    static let 型態屬性 = 1024
}


某個結構體.型態屬性
某個列舉.型態屬性


class 某個類別 {
    
    class var 型態屬性 : String{
        return "我是型態屬性"
        
    }
}

某個類別.型態屬性 









