import UIKit
import AVKit

extension ScanController: AVCaptureMetadataOutputObjectsDelegate {
    
    open func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard !metadataObjects.isEmpty else { return }
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
        guard Self.supportedCodeTypes.contains(object.type) else { return }
        guard let detectedData = convert(object: object) else { return }
        let observingData = detectQRCodeData(detectedData, self)
        guard let transformedObject = cameraView?.transformedMetadataObject(for: object) as? AVMetadataMachineReadableCodeObject else { return }
        
        let points = transformedObject.corners
        
        // Update Detail
        
        if let data = observingData {
            let splitter = ": "
            switch data {
            case .url(let url):
                detailView.setTitle(data.prefix + splitter + url.absoluteString)
                detailView.setImage(data.iconImage)
            case .text(let text):
                detailView.setTitle(data.prefix + splitter + text)
                detailView.setImage(data.iconImage)
            }
            
            
            if let bottomPoint = points.max(by: { $0.y < $1.y }) {
                if let secondBottomPoint = points.sorted(by: { $0.y < $1.y }).dropLast().max(by: { $0.y < $1.y }) {
                    let maxX = max(bottomPoint.x, secondBottomPoint.x)
                    let minX = min(bottomPoint.x, secondBottomPoint.x)
                    
                    let updateDetailFrame = {
                        self.detailView.sizeToFit()
                        let maximumDetailWidth = self.view.frame.width * 0.9
                        if self.detailView.frame.width > maximumDetailWidth {
                            self.detailView.frame.setWidth(maximumDetailWidth)
                        }
                        self.detailView.center.x = CGFloat(minX + ((maxX - minX) / 2))
                        self.detailView.frame.origin.y = bottomPoint.y + 16
                    }
                    
                    let animated = !detailView.isHidden
                    if animated {
                        UIView.animate(withDuration: 0.3, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                            updateDetailFrame()
                        }, completion: nil)
                    } else {
                        updateDetailFrame()
                    }
                }
            }
            
            qrCodeData = observingData
            
            // Update Frame
            
            frameLayer.update(using: points)
            
            // Timer
            
            updateTimer?.invalidate()
            updateTimer = Timer(fire: Date(timeIntervalSinceNow: 0.8), interval: 1, repeats: false, block: { _ in
                self.qrCodeData = nil
                self.frameLayer.dissapear()
            })
            
            RunLoop.main.add(updateTimer!, forMode: .default)
        }
        
        func convert(object: AVMetadataMachineReadableCodeObject) -> QRCodeData? {
            
            guard let string = object.stringValue else { return nil }
            
            if let components = URLComponents(string: string), components.scheme != nil {
                if let url = components.url {
                    return .url(url)
                }
            }
            
            return .text(string)
        }
    }
}
