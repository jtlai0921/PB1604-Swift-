//索引
class 女神類別{
    //定義一個備胎陣列
    let 備胎 = ["瀟灑哥","多金男","氣質大叔"]
    let age:Int = 30
    subscript(str:String)->Int{
        return age / 2
    }
    subscript(index:Int)->String{
        return 備胎[index]
    }
}
let 女神 = 女神類別()
//透過索引取得第0號被他
女神[0]
