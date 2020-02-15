//宣告一個可選值
var age:Int?

if age == nil {
    print("大叔，你到底多少歲啊？")
}else{
    print("大叔，原來你都\(age!)歲了啊")
}
//給可選值給予值
age = 34
if age == nil {
    print("大叔，你到底多少歲啊？")
}else{
    print("大叔，原來你都\(age!)歲了啊")
}
