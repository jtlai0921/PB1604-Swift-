//案例方法
class 女僕類別 {
    //案例方法
    func 打招呼(){
        print("主人，您回來了。")
    }
    //型態方法
    class func 暖床(){
        print("主人，電熱毯君已經把床暖好了")
    }
}
//呼叫型態方法
女僕類別.暖床()
//呼叫案例方法
let 女僕 = 女僕類別()
女僕.打招呼()

//self 屬性
class 御姐類別 {
    var age = 30
    func change(age :Int){
        self.age = age
    }
}
//結構體的mutating方法
struct 御姐結構體 {
    var age = 30
    mutating func change(age:Int){
        self.age = age
    }
}
