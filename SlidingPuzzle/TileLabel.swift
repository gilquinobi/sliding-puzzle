
import UIKit

class TileLabel: UILabel {
    var originCenter: CGPoint = .zero
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - View Methods
    private func setupView() {
        self.backgroundColor = .red
        self.isUserInteractionEnabled = true
        self.textColor = .black
        self.textAlignment = .center
    }
}
