import UIKit
import NativeUIKit
import PermissionsKit
import SPDiffable
import AlertKit
import OTP
import GAuthSwiftParser

extension HomeController {
    
    // MARK: - Actions
    
    @objc func scanButtonTapped() {
        
        scannedData = []
        
        if Permission.camera.notDetermined {
            Permission.camera.request {
                if Permission.camera.authorized {
                    self.scaning()
                }
            }
        } else if Permission.camera.denied {
            let alertController = UIAlertController(
                title: Texts.Permissions.denied_title,
                message: Texts.Permissions.denied_subtitle,
                preferredStyle: .alert
            )
            
            let settingsAction = UIAlertAction(title: Texts.Permissions.denied_action, style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: Texts.Shared.cancel, style: .default, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        } else {
            if Permission.camera.authorized {
                self.scaning()
            }
        }
        if Permission.camera.authorized {
            self.scaning()
        }
    }
    
    // MARK: - Methods
    
    // MARK: UI
    
    @objc func reload() {
        let time = Date().timeIntervalSince1970
        var partFrom30Seconds = Double(Int(time/30) + 1) - time/30
        partFrom30Seconds = Double(round(100 * partFrom30Seconds) / 100)
        let secondsBeforeUpdate = Int(partFrom30Seconds * 30)
        
        if !passwordsData.isEmpty {
            let barButtonItem = UIBarButtonItem(image: imageForNumber(number: secondsBeforeUpdate))
            self.navigationItem.rightBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        if secondsBeforeUpdate == 0 || secondsBeforeUpdate == 30 {
            self.diffableDataSource?.set(self.content, animated: false)
        }
        
    }
    
    // MARK: 2FA
    
    private func imageForNumber(number: Int) -> UIImage {
        let image = UIImage.system("\(number).circle.fill", font: UIFont.systemFont(ofSize: 19, weight: .medium))
        return image
    }
    
    private func cutSymbols(model: QRCodeData) -> String {
        var string = "\(model)"
        for _ in 0...3 {
            string.remove(at: string.startIndex)
        }
        string.remove(at: string.index(before: string.endIndex))
        
        return string
    }
    
    private func cutStringToLoginAndWebsite(string: String) -> [String] {
        var cuttedString = string
        cuttedString.remove(at: cuttedString.startIndex)
        let array = cuttedString.components(separatedBy: ":")
        
        return array
    }
    
    private func scaning() {
        QRCode.scanning(
            detect: { [self] data, controller in
                print(data.debugDescription)
                let tranformedData = self.cutSymbols(model: data!)
                if !scannedData.contains(tranformedData) {
                    scannedData.append(tranformedData)
                    checkType(dataQR: data!, controller: controller)
                }
                return data
            },
            handled: { data, controller in
                
            },
            on: self
        )
    }
    
    func checkType(dataQR: QRCodeData, controller: ScanController) {
        let tranformedData = self.cutSymbols(model: dataQR)
        guard let url = URL(string: tranformedData) else {
            AlertService.alertIncorrectURL()
            return
        }
        if url.scheme == "otpauth-migration" {
            handledGoogleParser(tranformedData: tranformedData, url: url, dataQR: dataQR, controller: controller)
        } else {
           handledQR(tranformedData: tranformedData, url: url, dataQR: dataQR, controller: controller)
        }
        
    }
    
    func handledGoogleParser(tranformedData: String, url: URL, dataQR: QRCodeData, controller: ScanController) {
        let accounts = GAuthSwiftParser.getAccounts(code: tranformedData)
        for account in accounts {
            if account.name == "" || account.issuer == "" || account.secret == "" {
                AlertService.alertIncorrectURL()
                self.dismiss(animated: true)
                return
            }
            if let url = URL(string: account.getLink()) {
                KeychainStorage.add(urls: [url])
            }
        }
        AlertService.code_added()
        controller.dismissAnimated()
    }
    
    func handledQR(tranformedData: String, url: URL, dataQR: QRCodeData, controller: ScanController) {
        
        let name = url.lastPathComponent
        let issuer = url.valueOf("issuer")
        let secret = url.valueOf("secret")
        
        guard let components = URLComponents(string: tranformedData) else {
            AlertService.alertNoToken()
            return
        }
        guard components.scheme != nil else {
            AlertService.alertNoToken()
            return
        }
        guard "\(components)".contains("secret") else {
            AlertService.alertNoToken()
            return
        }
        guard "\(components)".contains("totp") else {
            AlertService.alertNoToken()
            return
        }
        
        if secret == nil {
            AlertService.alertIncorrectURL()
            return
        }
        if tranformedData == .empty {
            AlertService.alertIncorrectURL()
            return
        }
        if issuer == nil {
            AlertService.alertIncorrectURL()
            return
        }
        if name.isEmpty {
            AlertService.alertIncorrectURL()
            return
        }
        
        guard let url = URL(string: tranformedData) else {
            AlertService.alertIncorrectURL()
            return
        }
        guard let token = url.valueOf("secret") else {
            AlertService.alertNoToken()
            return
        }
        guard let secret = base32DecodeToData(token) else {
            AlertService.alertNoToken()
            return
        }
        guard let checkCode = OTP.generateOTP(secret: secret) else {
            AlertService.alertNoToken()
            return
        }
        if checkCode.isEmpty {
            AlertService.alertNoToken()
            return
        }
        
        if issuer != nil && !name.isEmpty && !checkCode.isEmpty {
            
            if KeychainStorage.getAccounts().contains(where: { $0.secret == token }) {
                AlertService.alertTheSameCode()
                controller.dismissAnimated()
            } else {
                AlertService.code_added()
                controller.dismissAnimated()
            }
            
            KeychainStorage.add(urls: [url])

            passwordsData = KeychainStorage.getAccounts()
            diffableDataSource?.set(content, animated: true)
        } else {
            AlertService.alertIncorrectURL()
        }
    }
    
}
