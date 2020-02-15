//if
var age = 5
if age < 12 {
    print("正太")
}else if age > 30{
    print("大叔")
}else{
    print("騷年")
}


//switch

switch age {
case 0...11:
    print("正太")
case 12...30:
    print("騷年")
default:
    print("大叔")
}


//switch多值比對
let name = "路飛"
switch name {
    case "路飛","娜美","山治":
    print("它是海賊王裡的角色")
    case "黑崎一護","朽木露琪亞","朽木白哉":
    print("它是死神裡的角色")
    case "小傑":
    print("它是獵人裡面的角色")
default:
    print("它是哪部漫畫的角色呢？")
}

//switch的元群組比對
let 座標 = (1,1)

switch 座標 {
case (0,0):
    print("座標在原點")
case (_,0):
    print("座標在x軸上")
case (0,_):
    print("座標在y軸上")
case (-2...2 , -2...2):
    print("座標在長寬為4的正方形內")
    
default:
    print("在什麼地方呢")
}

//值綁定
var height = 1.73
switch height {
case let h:
    print("身高：\(h)")
    fallthrough
case 1.73:
    print("比對到1.73的case分支了")
default:
    print("嗯嗯，那啥")
}

//where
height = 2
switch height{
case 1...3 where height == 1.73:
    print("case 1")
case 1...3 where height == 2:
    print("case 2")
default:
    print("default君，我們又見面了")
}







