import UIKit
import SparrowKit
import NativeUIKit

extension ExportController {
    
    // MARK: - Actions
    
    @objc func close() {
        
        self.dismissAnimated()
    }
    
    @objc func copyQR() {
        
        AlertService.copied()
        UIPasteboard.general.string = copyLink
    }
    
    // MARK: - Methods
    
    func generateQRCode(from string: String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
}
