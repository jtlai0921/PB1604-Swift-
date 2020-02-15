import UIKit
//自訂http協定
protocol HttpProtocol{
    //定義一個方法接收一個字典
    func didRecieveResults(resultes:NSDictionary)
}
class HttpController:NSObject{
    //定義一個可選代理
    var delegate:HttpProtocol?
    
    //定義一個方法運過來取得網路資料，接收參數為網址
    
    func onSearch(url:String){
        //定義一個NSURL
        let nsUrl:NSURL=NSURL(string: url)!
        //定義一個NSURLRequest
        let request:NSURLRequest=NSURLRequest(URL: nsUrl)
        //異步取得資料
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse?,data:NSData?,error:NSError?)->Void in
            //由於我們取得的資料是json格式，所以我們可以將其轉化為字典。
            let jsonResult:NSDictionary=(try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            //將資料傳回給代理
            self.delegate?.didRecieveResults(jsonResult)
        })
        
    }
}
