import Foundation
import OTP

class AccountModel: NSObject, Codable {
    
    static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
        return lhs.url == rhs.url
    }
    
    var login: String
    var secret: String
    var issuer: String
    
    static func getByURL(_ url: URL) -> AccountModel? {
        let login = url.lastPathComponent
        guard let issuer = url.valueOf("issuer") else { return nil }
        guard let secret = url.valueOf("secret") else { return nil }
        let model = AccountModel(login: login, secret: secret, issuer: issuer)
        return model
    }
    
    init(login: String, secret: String, issuer: String) {
        self.login = login
        self.secret = secret
        self.issuer = issuer
    }
    
    var url: URL {
        let rawString = "otpauth://totp/\(login)?secret=\(secret)&issuer=\(issuer)"
        let urlString = rawString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: urlString)!
    }
    
    func getCode(for date: Date) -> String? {
        guard let decodedSecret = base32DecodeToData(secret) else { return nil }
        return OTP.generateOTP(secret: decodedSecret)
    }
}
