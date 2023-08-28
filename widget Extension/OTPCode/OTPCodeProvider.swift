import WidgetKit
import CryptoKit
import SwiftUI
import Intents
import SwiftBoost
import OTP

struct OTPCodeProvider: IntentTimelineProvider {
    
    func recommendations() -> [IntentRecommendation<SelectAccountIntent>] {
        return []
        // Widget not appear immidiatly on iOS if it enabled.
        /*var recommendations: [IntentRecommendation<SelectAccountIntent>] = []
        for account in KeychainStorage.getAccounts() {
            let intent = SelectAccountIntent()
            intent.account = convertToIntentAccount(account)
            let recomendation = IntentRecommendation(intent: intent, description: "Text Description \(account.issuer)")
            recommendations.append(recomendation)
        }
        return recommendations*/
    }
    
    var dataHidden: Bool {
        return (UserDefaults(suiteName: "group.io.sparrowcode.apps.otp-auth")?.bool(forKey: "hideWidgetData") ?? false)
    }
    
    func placeholder(in context: Context) -> OTPCodeEntry {
        Entry(
            otpCode: defaultCode,
            issuer: "sparrowcode.io",
            date: Date(),
            configuration: SelectAccountIntent()
        )
    }
    
    func getSnapshot(for configuration: SelectAccountIntent, in context: Context, completion: @escaping (OTPCodeEntry) -> ()) {
        let entry = Entry(
            otpCode: defaultCode,
            issuer: "sparrowcode.io",
            date: .now,
            configuration: configuration
        )
        completion(entry)
    }
    
    func getTimeline(for configuration: SelectAccountIntent, in context: Context, completion: @escaping (Timeline<OTPCodeEntry>) -> ()) {
        var entries: [Entry] = []
        let currentDate = Date().start(of: .minute)
        for codeIndex in 0...60 {
            let offset = TimeInterval(30 * codeIndex)
            let date = currentDate.addingTimeInterval(offset)
            let otpCode = getCodeBySecret(secret: configuration.account?.secret ?? .empty, for: date) ?? defaultCode
            let entry = Entry(
                otpCode: dataHidden ? hidenCode : otpCode,
                issuer: configuration.account?.issuer,
                date: date,
                configuration: configuration
            )
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func getCodeBySecret(secret: String, for date: Date) -> String? {
        guard let decodedSecret = base32DecodeToData(secret) else { return nil }
        guard let otp = OTPExtended.generateOTP(secret: decodedSecret, for: date) else { return nil }
        return otp.prefix(3) + " " + otp.suffix(3)
    }
    
    private var defaultCode: String {
        return "414 651"
    }
    
    private var hidenCode: String {
        return "••• •••"
    }
    
    private func convertToIntentAccount(_ account: AccountModel) -> IntentAccount {
        let intentAccount = IntentAccount(
            identifier: account.url.absoluteString,
            display: account.issuer + " (\(account.login))"
        )
        intentAccount.login = account.login
        intentAccount.issuer = account.issuer
        intentAccount.secret = account.secret
        return intentAccount
    }
}

// Becouse must to have special date
public enum OTPExtended {
    
    public static func generateOTP(secret: Data, algorithm: OTPAlgorithm = .sha1, expirationTimeInSeconds: Int = 30, digits: Int = 6, for date: Date = Date()) -> String? {
        
        let secondsPast1970 = Int(floor(date.timeIntervalSince1970))
        
        let counter = UInt64(floor(Double(secondsPast1970) / Double(expirationTimeInSeconds)))
        
        // HMAC message data from counter as big endian
        let counterMessage = counter.bigEndian.data
        
        // HMAC hash counter data with secret key
        var hmac = Data()
        
        switch algorithm {
        case .sha1:
            hmac = Data(HMAC<Insecure.SHA1>.authenticationCode(for: counterMessage, using: SymmetricKey(data: secret)))
        case .sha256:
            hmac = Data(HMAC<SHA256>.authenticationCode(for: counterMessage, using: SymmetricKey(data: secret)))
        case .sha512:
            hmac = Data(HMAC<SHA512>.authenticationCode(for: counterMessage, using: SymmetricKey(data: secret)))
        }
        
        
        // Get last 4 bits of hash as offset
        let offset = Int((hmac.last ?? 0x00) & 0x0f)
        
        // Get 4 bytes from the hash from [offset] to [offset + 3]
        let truncatedHMAC = Array(hmac[offset...offset + 3])
        
        // Convert byte array of the truncated hash to data
        let data =  Data(truncatedHMAC)
        
        // Convert data to UInt32
        var number = UInt32(strtoul(data.bytes.toHexString(), nil, 16))
        
        // Mask most significant bit
        number &= 0x7fffffff
        
        // Modulo number by 10^(digits)
        number = number % UInt32(pow(10, Float(digits)))
        
        // Convert int to string
        let strNum = String(number)
        
        // Return string if adding leading zeros is not required
        if strNum.count == digits {
            return strNum
        }
        
        // Add zeros to start of string if not present and return
        let prefixedZeros = String(repeatElement("0", count: (digits - strNum.count)))
        return (prefixedZeros + strNum)
    }
}

extension UInt64 {
    
    var data: Data {
        var int = self
        let intData = Data(bytes: &int, count: MemoryLayout.size(ofValue: self))
        return intData
    }
}
