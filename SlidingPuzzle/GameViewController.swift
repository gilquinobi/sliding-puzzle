
import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var boardView: UIView!
    var tileWidth: Int = 0
    var tileCenterX: Int = 0
    var tileCenterY: Int = 0
    
    var tileArray: NSMutableArray = []
    var tileCenterArray: NSMutableArray = []
    var tileEmpty: CGPoint = .zero
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initData()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initData()
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Controller Methods
    private func initData() {
    }
    
    private func setupView() {
        self.generateTiles()
        self.shuffleTiles()
    }
    
    private func generateTiles() {
        tileArray.removeAllObjects()
        tileCenterArray.removeAllObjects()
        
        let boardWidth = Int(self.boardView.bounds.width)
        tileWidth = boardWidth / 4
        tileCenterX = tileWidth / 2
        tileCenterY = tileWidth / 2
        
        var tileNumber: Int = 1
        
        for _ in 0..<4 {
            for _ in 0..<4 {
                let rect: CGRect = CGRect(x: 0, y: 0, width: tileWidth - 2, height: tileWidth - 2)
                let tileLabel = TileLabel(frame: rect)
                let currentCenter = CGPoint(x: tileCenterX, y: tileCenterY)
                tileLabel.center = currentCenter
                tileLabel.isUserInteractionEnabled = false
                tileLabel.text = "\(tileNumber)"
                
                tileCenterArray.add(currentCenter)
                
                boardView.addSubview(tileLabel)
                tileNumber = tileNumber + 1
                
                tileArray.add(tileLabel)
                
                tileCenterX = tileCenterX + tileWidth
            }
            tileCenterX = tileWidth / 2
            tileCenterY = tileCenterY + tileWidth
        }
        let lastTile = tileArray.lastObject as! UILabel
        lastTile.removeFromSuperview()
        tileArray.removeLastObject()
    }
    
    private func shuffleTiles() {
        let tempTileCenterArray: NSMutableArray = tileCenterArray.mutableCopy() as! NSMutableArray
        for anyTile in tileArray {
            let randomIndex: Int = Int(arc4random()) % tempTileCenterArray.count
            let randomCenter: CGPoint = tempTileCenterArray[randomIndex] as! CGPoint
            (anyTile as! TileLabel).center = randomCenter
            
            tempTileCenterArray.removeObject(at: randomIndex)
        }
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        self.shuffleTiles()
    }
}

