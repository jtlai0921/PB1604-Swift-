//有個大叔他叫老鎮，年齡34歲，身高1公尺73
let 大叔 = ("老鎮",34,1.73)

//將元群組分解成單獨的常數
let (name,age,height) = 大叔
print("大叔叫：\(name)")
print("大叔年齡：\(age) 歲")
print("大叔身高：\(height) 米")

let (_,age2,_) = 大叔
print("大叔的年齡是：\(age2) 歲")

print("大叔叫：\(大叔.0)")
print("大叔年齡：\(大叔.1) 歲")
print("大叔身高：\(大叔.2) 米")

let 大叔2號 = (name:"老鎮",age:34,height:1.73)
print("大叔2號叫：\(大叔2號.name)")
print("大叔2號年齡：\(大叔2號.age) 歲")
print("大叔2號身高：\(大叔2號.height) 米")
