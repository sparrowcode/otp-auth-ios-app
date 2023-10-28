import UIKit
import NativeUIKit
import SparrowKit
import SafeSFSymbols
import AVKit

extension ScanController {
    
    // MARK: - Actions
    
    @objc func close() {
        UIView.animate(withDuration: 0.32, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0) {
            self.scanView.frame.origin.y = self.view.frame.height + 40
            self.view.backgroundColor = .black.alpha(0)
        } completion: { finished in
            self.dismiss(animated: false)
        }
    }
    
    @objc func didTapHandledButton() {
        guard let data = qrCodeData else { return }
        handledQRCodeData?(data, self)
    }
    
    @objc func didTapCancelButton() {
        dismissAnimated()
    }
    
    // MARK: - Methods
    
    internal static let supportedCodeTypes = [
        AVMetadataObject.ObjectType.aztec,
        AVMetadataObject.ObjectType.qr
    ]
    
    internal func updateInterface() {
        let duration: TimeInterval = 0.22
        if qrCodeData != nil {
            detailView.isHidden = false
            UIView.animate(withDuration: duration, delay: .zero, options: .curveEaseInOut, animations: {
                self.detailView.transform = .identity
                self.detailView.alpha = 1
            })
        } else {
            UIView.animate(withDuration: duration, delay: .zero, options: .curveEaseInOut, animations: {
                self.detailView.transform = .init(scale: 0.9)
                self.detailView.alpha = .zero
            }, completion: { _ in
                self.detailView.isHidden = true
            })
        }
    }
    
    internal func makeVideoPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        guard let captureSession else { return nil }
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.cornerRadius = scanView.cameraPreview.layer.cornerRadius
        videoPreviewLayer.videoGravity = .resizeAspectFill
        return videoPreviewLayer
    }
    
    internal func makeCaptureSession() -> AVCaptureSession {
        let captureSession = AVCaptureSession()
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { fatalError() }
        guard let input = try? AVCaptureDeviceInput(device: device) else { fatalError() }
        captureSession.addInput(input)
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = Self.supportedCodeTypes
        return captureSession
    }
    
}
