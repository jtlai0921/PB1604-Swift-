import UIKit



class TodoDetailController: UITableViewController ,ProtocolLevel,UITextFieldDelegate{

    @IBOutlet weak var labLevel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    //加入還是編輯狀態
    var isAdd:Bool = true
    //加入還是編輯都要用到的工作資料
    var todoItem = TodoItem()
    //ProtocolTodoDetail 協定代理
    var delegate : ProtocolTodoDetail?
    
    //日期選取器顯示狀態
    var datePickerVisible:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isAdd {
            todoItem = TodoItem()
            doneButton.enabled = false
        }else{
            self.title="編輯工作"
            textField.text = todoItem.text
            switchControl.on = todoItem.shouldRemind
        }
        textField.delegate = self
        textField.becomeFirstResponder()
        labLevel.text = LevelItem.onGetTitle(todoItem.level)
        upDateDueDateLabel()

    }
    //Cancel按鈕響應方法
    @IBAction func cancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    //Done按鈕響應方法
    @IBAction func done(sender: AnyObject) {
        todoItem.text = self.textField.text!
        todoItem.shouldRemind = self.switchControl.on
        if isAdd {
            //新增資料
            delegate?.addItem(todoItem)
        }else{
            //同時修改資料中的text為文字框編輯後的內容
            delegate?.editItem()
        }
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        todoModel.saveData()
        todoItem.scheduleNotification()
    }
    
    //設定cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //因為日期選取器的位置在日期顯示Label下面。它的位置就是第2個section  和第3個row
        if indexPath.section == 1 && indexPath.row == 3{
            //用重用的模式取得標誌為DatePickerCell的cell
            var cell = tableView.dequeueReusableCellWithIdentifier("DatePickerCell") as UITableViewCell?
            //若果沒找到就建立一個
            if cell == nil {
                //建立一個標誌為DatePickerCell的cell
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "DatePickerCell")
                //設定cell的型態
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                //建立日期選取器
                let datePicker = UIDatePicker(frame: CGRectMake(0.0, 0.0, 320.0, 216.0))
                //給日期選取器的tag
                datePicker.tag = 100
                //將日期選取器加入cell
                cell?.contentView.addSubview(datePicker)
                //注意：action裡面的方法名後面需要加個冒號“：”
                datePicker.addTarget(self, action: "dateChanged:", forControlEvents: UIControlEvents.ValueChanged)
            }
            return cell!
        }else{
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    //日期選取器響應方法
    func dateChanged(datePicker : UIDatePicker){
        //改變dueDate
        todoItem.dueDate = datePicker.date
        //更新提醒時間文字框
        upDateDueDateLabel()
    }
    //根據日期選取器的隱藏與否決定傳回的row的數量
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 1  && datePickerVisible{
            return 4
        }else{
            return super.tableView(tableView, numberOfRowsInSection: section)
            
        }
    }
    //因為日期選取器插入後會引起cell高度的變化，所以要重新設定
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //當著色到達日期選取器所在的cell的時候將cell的高度設為217
        if indexPath.section == 1 && indexPath.row == 3{
            return 216.0
        }else{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    //當覆蓋了靜態的cell資料源方法時需要提供一個代理方法。因為資料源對新加進來的日期選取器的cell一無所知，所以要使用這個代理方法
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 3{
            //當執行到日期選取器所在的indexPath就建立一個indexPath然後強插
            let newIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: newIndexPath)
        }else{
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
        }
    }
    
    //更新顯示時間的Label
    func upDateDueDateLabel(){
        let formatter = NSDateFormatter()
        //日期型態
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        self.dueDateLabel.text = formatter.stringFromDate(todoItem.dueDate)
    }
    //選取cell的row之後
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textField.resignFirstResponder()
        //當執行到日期選取器上一行的時候，可以判斷是否要顯示日期選取器了
        if indexPath.section == 1 && indexPath.row == 2{
            if !datePickerVisible{
                self.showDatePicker()
            }else{
                self.hideDatePicker()
            }
        }
    }
    
    
    //顯示日期選取器
    func showDatePicker(){
        //日期選取器的狀態設為開啟
        datePickerVisible = true
        
        let indexPathDatePicker = NSIndexPath(forRow: 3, inSection: 1)
        self.tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }
    
    //隱藏日期選取器
    func hideDatePicker(){
        if datePickerVisible {
            //日期選取器的狀態設為關閉
            datePickerVisible = false
            let indexPathDatePicker = NSIndexPath(forRow: 3, inSection: 1)
            self.tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    //ProtocolLevel協定索要實現的方法
    func onGetLevel(levelItem: LevelItem) {
        //更新重要等級的文字標簽
        labLevel.text = levelItem.title
        //更新todoItem中的等級
        todoItem.level = levelItem.level
        //關閉等級選取界面
        self.navigationController?.popViewControllerAnimated(true)
    }
    //連線跳躍
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //取得跳躍目的
        let controller = segue.destinationViewController as! TodoLevelController
        //設定代理
        controller.delegate = self
        //傳參並產生資料源
        controller.onSetCheckMark(self.todoItem.level)
        
    }
    
    //textfield將要改變的時候響應的函數
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //取得到文字框內最新的文字
        let newText = textField.text!.stringByReplacingCharactersInRange(range.toRange(textField.text!), withString: string)
        //透過計算文字框內的字元數來決定確定按鈕是否啟動
        doneButton.enabled = newText.characters.count > 0
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//寫個代理協定，用於回調
protocol ProtocolTodoDetail {
    func addItem(item:TodoItem)
    func editItem()
}