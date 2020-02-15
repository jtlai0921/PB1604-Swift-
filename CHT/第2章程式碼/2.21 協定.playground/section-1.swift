//協定，遵循屬性
protocol 某個協定 {
    //讀寫屬性
    var name:String{get set}
    //只讀屬性
    var age:Int{get}
}

//遵循方法
protocol 某某協定{
    //型態方法
    static func 某某方法()
    //案例方法
    func 某某方法() -> Int
    //突變方法
    mutating func 某某突變方法()
}

