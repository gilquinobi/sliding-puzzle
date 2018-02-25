
import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var boardView: UIView!
    var tileWidth: Int = 0
    var tileCenterX: Int = 0
    var tileCenterY: Int = 0
    
//    var tileArray = []
//    var tileCenterArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        
    }
}

