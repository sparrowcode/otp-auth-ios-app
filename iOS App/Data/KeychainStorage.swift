import Foundation
import KeychainAccess
import SwiftyJSON

enum KeychainStorage {
    
    private static let keyID = "totp"
    
    static func getAccounts(with keychainID: String = Constants.Keychain.service) -> [AccountModel] {
        
        // Get urls
        let keychain = Keychain(service: keychainID)
        var urls: [URL] = []
        for key in keychain.allKeys() {
            if let rawString = keychain[key], let url = URL(string: rawString) {
                urls.append(url)
            }
        }
        
        //self.delete(urls: urlToDelete)
        
        // Convert to accounts
        var accounts: [AccountModel] = []
        var toDeleteURLs: [URL] = []
        for url in urls {
            let login = url.lastPathComponent
            guard let issuer = url.valueOf("issuer") else { continue }
            guard let secret = url.valueOf("secret") else { continue }
            let account = AccountModel(login: login, secret: secret, issuer: issuer)
            
            
            if accounts.contains(where: { $0.issuer == issuer && $0.secret == secret && $0.login == login }) {
                toDeleteURLs.append(url)
            } else {
                accounts.append(account)
            }
        }
        
        self.delete(urls: toDeleteURLs)
        
        return accounts.sorted(by: { $0.issuer < $1.issuer })
    }
    
    static func add(urls: [URL], with keychainID: String = Constants.Keychain.service) {
        if urls.isEmpty { return }
        let keychain = Keychain(service: keychainID)
        
        for url in urls {
            keychain[url.absoluteString] = url.absoluteString
        }
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
    
    static func delete(urls: [URL], with keychainID: String = Constants.Keychain.service) {
        if urls.isEmpty { return }
        let keychain = Keychain(service: keychainID)
        for url in urls {
            if let secrect = url.valueOf("secret") {
                if let key = keychain.allKeys().first(where: { $0.contains(secrect) }) {
                    keychain[key] = nil
                }
            }
        }
        NotificationCenter.default.post(name: .changedAccounts, object: nil)
    }
}

extension Notification.Name {
    
    static var changedAccounts = Notification.Name("changedAccounts")
}

public extension Array where Element: Equatable {
    
    func removedDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}
