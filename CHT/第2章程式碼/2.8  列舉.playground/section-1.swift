//列舉語法
enum 年齡段 {
    case 正太
    case 騷年
    case 大叔
    case 大爺
}
let 老鎮的年齡段 = 年齡段.大叔
switch 老鎮的年齡段 {
case 年齡段.正太:
    print("絕對不可能是正太，一定搞錯了")
case 年齡段.騷年:
    print("大叔你裝嫩呢")
case 年齡段.大叔:
    print("果然是一個大叔啊")
case 年齡段.大爺:
    print("大叔還年輕著呢")
default:
    print("不知道他屬於哪個年齡段")
}
