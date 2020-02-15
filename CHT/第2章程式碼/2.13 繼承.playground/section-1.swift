//定義一個基礎類別

class 妹紙類別 {
    var name:String = "一個妹紙"
    var age:Int = 18
    func sayHi(){
        print("你好，我是\(name) ，今年\(age)歲")
    }
}

class 女神類別:妹紙類別{
    
}

let 女神 = 女神類別()
女神.name = "繆斯"
女神.age = 22
女神.sayHi()

//女王類別，繼承妹紙類別
class 女王類別:妹紙類別{
    //重新定義屬性的get和set方法
    override var name:String{
        get{
            return self.name
        }set{
            self.name = newValue
        }
    }
    //重新定義屬性監視器
    override var age:Int{
        willSet{
            //程式碼
        }
        didSet{
            //程式碼
        }
    }
    override func sayHi() {
        print("叫我女王，顫抖吧凡人")
    }
}
let 女王 = 女王類別()
女王.sayHi()
