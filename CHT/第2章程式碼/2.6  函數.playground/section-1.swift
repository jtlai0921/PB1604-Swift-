//定義函數
func sayHi(name:String)->String{
    let str = "你好\(name)"
    return str
}

let str = sayHi("老鎮")
print(str)

//傳入多個值
func sayHi2(name:String,age:Int) -> String{
    let str = "有個大叔叫\(name),今年\(age)歲"
    return str
}

let str2 = sayHi2("老鎮", age: 34)
print(str2)

//無參
func sayHi3() -> String{
    let str="你夠了，我已經打了很多次了招呼了！"
    return str
}
let str3 = sayHi3()
print(str3)
//無傳回型態
func sayHi4(){
    //....
}

//傳回多個值
func sayHi5()->(name:String,age:Int,height:Int){
    
    return ("老鎮",34,173)
    
}
let eko = sayHi5()
print("有個大叔叫\(eko.name)，他今年\(eko.age)歲，身高\(eko.height)")

//外部參數名
func sayHi6(Who name:String,HowOld age:Int)->String{
    let str = "有個大叔叫\(name),今年\(age)歲"
    return str
}
let str6 = sayHi6(Who: "老鎮", HowOld: 34)
print("\(str6)")

//對外參數名和參數名一致
func sayHi7(name name:String,age:Int)->String{
    let str = "有個大叔叫\(name),今年\(age)歲"
    return str
}
let str7 = sayHi7(name: "老鎮", age: 34)

//對外參數名和參數名一致
func sayHi8(name name:String,age:Int)->String{
    let str = "有個大叔叫\(name),今年\(age)歲"
    return str
}
let str8 = sayHi8(name: "老鎮", age: 34)

//常數，變數 參數
var age = 34
func add(var age:Int){
    age += 1
}

//in-out參數
func changeAge(inout age:Int){
    age = 35
}
changeAge(&age)
print(age)













