
import UIKit

class ViewController: UIViewController {
    //關聯兩個控制項
    @IBOutlet weak var pc: UIPageControl!
    @IBOutlet weak var iv: UIImageView!
    var arrImage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //產生圖片源頭陣列
        for i in 1...3 {
            let img = UIImage(named: "image\(i).jpg")
            arrImage.append(img!)
        }
        onSetImage(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onPageChanged(sender: AnyObject) {
        onSetImage(self.pc.currentPage)
    }
    //改變ImageView顯示的圖片
    func onSetImage(index:Int){
        iv.image = arrImage[index]
    }

}

