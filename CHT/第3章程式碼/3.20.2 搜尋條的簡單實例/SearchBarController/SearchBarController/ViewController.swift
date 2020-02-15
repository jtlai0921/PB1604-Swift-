
import UIKit

class ViewController: UIViewController,UISearchBarDelegate{
    //原始資料
    let arrTitle = ["海賊王 One Piece","獵人 Hunter X Hunter","死神 Bleach","火影忍者 Hokage","城市獵人 City Hunter","大劍 Claymore","劍風傳奇 Baserk","閃靈 Get Backers","灌籃高手 Slamdunk","浪客劍心 Rurouni Kenshin","軍雞 Shamo","伊甸園 Eden","地獄老師 Hell Teacher","JOJO冒險"]
    //搜尋狀態
    var isSearch = false
    //搜尋資料
    var arrSearch = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        //透過搜尋狀態來判斷使用哪個陣列作為表格的行數。
        if isSearch {
            return arrSearch.count
        }else{
            return arrTitle.count
        }
        
    }
    //設定單元格
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let index = indexPath.row
        //透過搜尋狀態來設定單元格的資料
        if isSearch {
            cell.textLabel.text = arrSearch[index]
        }else{
            cell.textLabel.text = arrTitle[index]
        }
        
        return cell
    }
    //UISearchBarDelegate方法，取消搜尋響應函數
    func searchBarCancelButtonClicked(searchBar: UISearchBar!) {
        isSearch = false
    }
    //searchbar 內容改變
    func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!) {
        onSearch(searchText)
        
    }
    //響應虛擬鍵碟上的search按鈕的函數
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        self.searchDisplayController?.searchBar.resignFirstResponder()
    }
    //搜尋函數
    func onSearch(str:String){
        isSearch = true
        arrSearch = [String]()
        for title in arrTitle {
            let index = title.rangeOfString(str)
            if (index?.isEmpty != nil)  {
                self.arrSearch.append(title)
            }
        }
        
    }
}

