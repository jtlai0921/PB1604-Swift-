

import UIKit

class ViewController: UIViewController {
    //關聯兩個ImageView
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    var arrImage:[UIImage] = [UIImage]()
    var _index = 0
    var index:Int{
        get{
            return _index
        }
        set{
            _index = newValue
            if _index < 0 {
                _index += 3
            }else if _index > 2 {
                _index -= 3
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //透過for循環建立3個UIImage作為ImageView的圖片原
        for i in 1...3 {
            let image = UIImage(named: "image\(i).jpg")
            arrImage.append(image!)
        }
        onSetImage()
        
        //自動切換圖片的UIImageView元件
        image2.animationImages = arrImage
        image2.animationDuration = 2
        //循環次數 0  表示無限循環
        image2.animationRepeatCount = 0
        image2.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //下一張按鈕點擊響應函數
    @IBAction func onNext(sender: AnyObject) {
        index--
        onSetImage()
    }
    //上一張按鈕點擊響應函數
    @IBAction func onPre(sender: AnyObject) {
        index++
        onSetImage()
    }
    func onSetImage(){
        image.image = arrImage[index]
    }
}

