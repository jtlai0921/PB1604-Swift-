//先定義一個女神類別
class 女神類別{
    var name:String
    init(name:String){
        self.name=name
    }
    
}
//然後我們來對女神類別進行計算型屬性延伸
extension 女神類別{
    var age:Int { return 24 }
}


//延伸建構器
extension 女神類別{
    convenience init(name:String,age:Int){
    self.init(name:name)
    print("延伸了新的建構器")
    }
}


//延伸方法
extension 女神類別{
    func sayHi(){
        print("來，打個招呼！")
    }

}

//延伸索引
extension 女神類別{
    subscript(index:Int)->Void{
        print("成功延伸了索引")
    }
}

//延伸嵌套型態
extension 女神類別{
    enum 性格列舉:String{
        case 溫柔="溫柔",可愛="可愛",俏皮="俏皮",大方="大方"
    }
    var 性格:性格列舉{
        return .溫柔
    }
    func 性格怎樣(){
        print("\(性格.rawValue)")
    }
}

let 女神 = 女神類別(name: "繆斯",age:20)
女神.age
女神.sayHi()
女神[0]
女神.性格怎樣()
