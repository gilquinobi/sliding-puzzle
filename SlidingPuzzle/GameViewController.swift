
import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var boardView: UIView!
    var tileWidth: CGFloat = 0
    var tileCenterX: CGFloat = 0
    var tileCenterY: CGFloat = 0
    let tilesPerLine = 4
    let test = "test";
    var tileArray: NSMutableArray = []
    var tileCenterArray: NSMutableArray = []
    var tileEmptyCenter: CGPoint = .zero
    
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
        
        let boardWidth = self.boardView.bounds.width
        tileWidth = boardWidth / CGFloat(tilesPerLine)
        tileCenterX = tileWidth / 2
        tileCenterY = tileWidth / 2
        
        var tileNumber: Int = 1
        
        for _ in 0..<tilesPerLine {
            for _ in 0..<tilesPerLine {
                let rect: CGRect = CGRect(x: 0, y: 0, width: tileWidth - 2, height: tileWidth - 2)
                let tileLabel = TileLabel(frame: rect)
                let currentCenter = CGPoint(x: tileCenterX, y: tileCenterY)
                tileLabel.center = currentCenter
                tileLabel.originCenter = currentCenter
//                tileLabel.text = "\(tileNumber)"
                
                if tileNumber <= 16 {
                    tileLabel.backgroundColor = UIColor(patternImage: UIImage(named: "\(tileNumber)")!)
                } else {
                    tileLabel.backgroundColor = .gray
                }
                
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
        tileEmptyCenter = tempTileCenterArray.firstObject as! CGPoint
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.shuffleTiles()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentTouch: UITouch = touches.first!
        if tileArray.contains(currentTouch.view as Any) {
            let tileLabel = currentTouch.view as! TileLabel
            let xDiff = tileLabel.center.x - tileEmptyCenter.x
            let yDiff = tileLabel.center.y - tileEmptyCenter.y
            let delta: CGFloat = sqrt(pow(xDiff, 2) + pow(yDiff, 2))
            if delta == tileWidth {
                let tempCenter = tileLabel.center
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                tileLabel.center = tileEmptyCenter
                UIView.commitAnimations()
                tileEmptyCenter = tempCenter
            }
        }
    }
}
