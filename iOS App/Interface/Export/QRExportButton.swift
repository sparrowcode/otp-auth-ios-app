import UIKit
import SparrowKit
import NativeUIKit

class QRExportButton: SPButton {
    
    // MARK: - Views
    
    let QRImageView = UIImageView().do {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        backgroundColor = .white
        layer.cornerRadius = 15
        addSubview(QRImageView)
    }
    
    // MARK: - Layout
    
    #warning("Scale not work")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard transform == .identity else { return }
        QRImageView.frame = .init(
            x: 0, y: 0,
            width: self.frame.width - 15,
            height: self.frame.height - 15
        )
        QRImageView.setXCenter()
        QRImageView.setYCenter()
    }
    
    // MARK: - Methods
    
    override var isHighlighted: Bool {
        
        didSet {
            
            QRImageView.alpha = isHighlighted ? 0.6 : 1
            QRImageView.transform = isHighlighted ? CGAffineTransform(scale: 0.9) : .identity
        }
    }
}
