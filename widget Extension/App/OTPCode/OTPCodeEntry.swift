import Foundation
import WidgetKit

struct OTPCodeEntry: TimelineEntry {
    
    let otpCode: String
    let issuer: String?
    let date: Date
    
    let configuration: SelectAccountIntent
    
    static func getURL(for entry: OTPCodeProvider.Entry) -> URL? {
        return URL(string: "otpauth://copycode?code=\(entry.otpCode.replacingOccurrences(of: " ", with: ""))")
    }
    
    static var preview: OTPCodeEntry {
        .init(otpCode: "123456", issuer: "sparrowcode.io", date: .now, configuration: SelectAccountIntent())
    }
}
