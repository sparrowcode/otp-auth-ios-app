import Foundation
import WidgetKit

struct OTPCodeEntry: TimelineEntry {
    
    let otpCode: String
    let issuer: String?
    let date: Date
    
    let configuration: SelectAccountIntent
}
