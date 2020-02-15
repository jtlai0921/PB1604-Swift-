

import UIKit

class ViewController: UIViewController ,UISearchBarDelegate{
    
    @IBOutlet weak var sb: UISearchBar!
    @IBOutlet weak var tv: UITableView!
    let arrTitle = ["海賊王 One Piece","獵人 Hunter X Hunter","死神 Bleach","火影忍者 Hokage","城市獵人 City Hunter","大劍 Claymore","劍風傳奇 Baserk","閃靈 Get Backers","灌籃高手 Slamdunk","浪客劍心 Rurouni Kenshin","軍雞 Shamo","伊甸園 Eden","地獄老師 Hell Teacher","JOJO冒險"]
    var arrSearch = [String]()
    var isSearch:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        sb.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //設定tableview的行數
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            //搜尋中用arrSearch作為tv的行數
            return arrSearch.count
        }else{
            //離開搜尋時用原始資料作為tv的行數
            return arrTitle.count
        }
    }
    //設定單元格cell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        if isSearch {
            //搜尋中時使用arrSearch作為tv的資料源
            cell.textLabel!.text = arrSearch[index]
        }else{
            //離開搜尋時用arrTitle作為tv的資料源
            cell.textLabel!.text = arrTitle[index]
        }
        
        return cell
    }
    
    //UISearchBarDelegate方法，取消search
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //搜尋狀態改為false
        isSearch = false
        //清理搜尋條文字
        sb.text=""
        //關閉虛擬鍵碟
        sb.resignFirstResponder()
        //tv多載資料
        tv.reloadData()
    }
    //searchbar 內容改變
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        onSearch(searchText)
        
    }
    //響應虛擬鍵碟上的search按鈕
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("search button")
        onSearch(sb.text!)
        sb.resignFirstResponder()
    }
    
    //搜尋函數
    func onSearch(str:String){
        //搜尋狀態設為true
        isSearch = true
        //將arrSearch陣列清理
        arrSearch = [String]()
        for title in arrTitle {
            //利用rangeOfString方法來判斷漫畫名是否包括搜尋的文字
            let index = title.rangeOfString(str)
            //若果包括就放入arrSearch中
            if (index?.isEmpty != nil)  {
                self.arrSearch.append(title)
            }
        }
        tv.reloadData()
    }
    

}

