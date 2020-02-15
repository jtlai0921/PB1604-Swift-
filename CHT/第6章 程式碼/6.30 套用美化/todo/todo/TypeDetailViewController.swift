import UIKit

class TypeDetailViewController: UITableViewController,ProtocolIconView,UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //定義一個TypeItem型態的屬性
    var typeItem:TypeItem = TypeItem(name: "")
    //設定狀態，是加入分類別還是編輯分類別
    var isAdd:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定文字框的代理
        textField.delegate = self
    }
    //檢視載入完畢之後執行的方法
    override func viewWillAppear(animated: Bool) {
        onUpdate()
        textField.becomeFirstResponder()
        if isAdd {
            doneButton.enabled = false
        }else{
            doneButton.enabled = true
        }
    }
    //取消按鈕
    @IBAction func cancel(sender: AnyObject) {
        //界面跳躍
        self.tabBarController?.selectedIndex = 0
        //復原成加入狀態
        onAddType()
    }
    //響應確定按鈕的方法
    @IBAction func done(sender: AnyObject) {
        //取得分類別名稱
        typeItem.name = textField.text!
        
        if isAdd {
            //將新的分類別加進分類別陣列
            todoModel.onAddType(typeItem)
        }else{
            //取得工作分類別檢視的導覽控制器
            let navigation = self.tabBarController?.viewControllers?[0] as! UINavigationController
            //取得工作分類別檢視
            let typeView = navigation.viewControllers.first as? TypeViewController
            //更新工作分類別檢視的資料
            typeView?.tableView.reloadData()
        }
        
        //界面跳躍
        self.tabBarController?.selectedIndex = 0
        //復原成加入狀態
        onAddType()
        //儲存資料
        todoModel.saveData()
        //資料排序
        todoModel.sortLists()
    }
    //加入分類別方法
    func onAddType(){
        //將標誌設為加入工作分類別狀態
        isAdd = true
        //將typeItem設為新的空資料
        typeItem = TypeItem(name: "")
        //設定檢視標題
        self.title = "加入"

    }
    //編輯分類別方法
    func onEditType(item:TypeItem){
        //將標示設為編輯工作分類別狀態
        isAdd = false
        //設定標題
        self.title = "編輯分類別"
        //接收傳過來的分類別資料
        self.typeItem = item
        
    }
    //更新界面方法
    func onUpdate(){
        self.textField.text = typeItem.name
        iconImageView.image = UIImage(named: typeItem.icon)
    }
    
    //檢驗界面切換
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //取得切換目的
        let controller = segue.destinationViewController as! IconViewController
        //設定代理
        controller.delegate = self
        
    }
    //設定圖示
    func iconPicker(didPickIcon iconName:String){
        
        typeItem.icon = iconName
        iconImageView.image = UIImage(named: iconName)
        //關閉選取圖示界面
        self.navigationController?.popViewControllerAnimated(true)
    }
    //textfield將要改變的時候響應的函數
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //取得到文字框內最新的文字
        let newText = textField.text!.stringByReplacingCharactersInRange(range.toRange(textField.text!), withString: string)
        //透過計算文字框內的字元數來決定done按鈕是否啟動
        doneButton.enabled = newText.characters.count > 0
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//延伸NSRange，讓swift的string能使用stringByReplacingCharactersInRange
extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.startIndex.advancedBy(self.location)
        let endIndex = startIndex.advancedBy(self.length)
        return startIndex..<endIndex
    }
}