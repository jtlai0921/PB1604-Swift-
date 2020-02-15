//型態轉換
//定義妹紙類別
class 妹紙類別{
    
}

//定義女神類別
class 女神類別:妹紙類別{
    
}
//定義女王類別
class 女王類別:妹紙類別{
    
}

let 女王 = 女王類別()
let 女神 = 女神類別()

var 陣列 = [女王,女神]

for 妹紙 in 陣列 {
    if 妹紙 is 女王類別 {
        print("這個妹紙是女王類別的案例")
    }else if 妹紙 is 女神類別{
        print("這個妹紙是女神類別的案例")
    }
}


for 妹紙 in 陣列 {
    if let 女王 = 妹紙 as? 女王類別 {
        print("這個妹紙是女王類別的案例")
    }else if let 女神 = 妹紙 as? 女神類別{
        print("這個妹紙是女神類別的案例")
    }
}

//AnyObject型態
var 陣列2:[AnyObject]=[女王,女神]
for obj in 陣列2 {
    if let 女王 = obj as? 女王類別 {
        print("這個妹紙是女王類別的案例")
    }else if let 女神 = obj as? 女神類別{
        print("這個妹紙是女神類別的案例")
    }
}

//Any型態

var 陣列3:[Any]=[Any]()
陣列3.append(1)
陣列3.append("老鎮")
陣列3.append(女王)
陣列3.append(女神)

for any in 陣列3 {
    switch any {
    case let any as Int:
        print("這是一個Int型態")
    case let any as String:
        print("這是一個String型態")
    case let any as 女王類別:
        print("這是一個女王類別的案例")
    case let any as 女神類別:
        print("這是一個女神類別的案例")
    default:
        print("我只是過路的，完全不認識這家伙")
    }
}



