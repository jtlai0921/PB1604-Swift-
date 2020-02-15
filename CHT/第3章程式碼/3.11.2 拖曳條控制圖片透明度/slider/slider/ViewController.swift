import UIKit

class ViewController: UIViewController {
    //關聯拖曳條元件和圖形元件
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //響應拖曳條的值的改變，進一步設定圖形群組建的透明度
    @IBAction func onChange(sender: AnyObject) {
        img.alpha = CGFloat(slider.value)
    }

}

