class LevelItem{
    //重視程度
    var level:Int
    //重視程度的標題
    var title:String = ""
    //cell是否選取情況
    var checkMark:Bool = false
    init(level:Int){
        self.level = level
        self.title = LevelItem.onGetTitle(level)
    }
    class func onGetTitle(level:Int)->String{
        var title:String = ""
        switch level {
        case 0 :
            title = "非常重要"
        case 1:
            title = "很重要"
        case 2:
            title = "重要"
        case 3:
            title = "一般"
        case 4:
            title = "可忽略"
        default:
            title = "非常重要"
        }
        return title
    }
}
