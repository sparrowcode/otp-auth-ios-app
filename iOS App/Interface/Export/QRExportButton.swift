import UIKit
import SparrowKit
import NativeUIKit

class QRExportButton: SPButton {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.22, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.6 : 1
                self.transform = self.isHighlighted ? CGAffineTransform(scale: 0.9) : .identity
            })
        }
    }
    
    // MARK: - Views
    
    let qrImageView = UIImageView().do {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        backgroundColor = .white
        layer.cornerRadius = 15
        addSubview(qrImageView)
    }
    
    // MARK: - Layout
    
    #warning("Scale not work")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard transform == .identity else { return }
        qrImageView.frame = .init(
            x: 0, y: 0,
            width: self.frame.width - 15,
            height: self.frame.height - 15
        )
        qrImageView.setXCenter()
        qrImageView.setYCenter()
    }
}
