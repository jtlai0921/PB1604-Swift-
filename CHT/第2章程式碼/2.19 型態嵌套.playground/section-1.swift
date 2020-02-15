//型態嵌套
struct 撲克牌結構體{
    enum 花色列舉:String{
        case 紅桃="紅桃",草花="草花",方片="方片",黑桃="黑桃"
    }
    enum 面值列舉:Int{
        case Two=2,Three,Four,Five,Six,Seven,Eight,Nine,Ten
        case 丁鉤,皮蛋,老K,尖刀
    }
    let 花色:花色列舉
    let 面值:面值列舉
    func 描述(){
        print("這張牌的花色是\(花色.rawValue)，牌的面值是\(面值.rawValue)")
    }
}
let 撲克牌 = 撲克牌結構體(花色:.紅桃, 面值: .Two)
撲克牌.描述()
