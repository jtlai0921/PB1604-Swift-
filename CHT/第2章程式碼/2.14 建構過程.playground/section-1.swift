//預設建構方法

class 女神類別{
    let 相貌:String
    init(){
        相貌="95分"
    }
}

//自訂建構方法

class 妹紙類別{
    var age:Int
    init(age:Int){
        self.age = age
    }
}
let 妹子 = 妹紙類別(age: 18)

//指定建構器和便利建構器
class 蘿莉類別{
    var name:String
    //指定建構器
    init(name:String){
        self.name = name
    }
    //便利建構器
    convenience init(name:String,age:Int){
        self.init(name:name)
    }
}
