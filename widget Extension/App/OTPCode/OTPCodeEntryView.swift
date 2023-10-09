import WidgetKit
import SwiftBoost
import SwiftUI
import Intents
import OTP
import SwiftUIExtension

struct OTPCodeEntryView : View {
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: OTPCodeProvider.Entry
    
    var body: some View {
        switch widgetFamily {
        #if os(iOS)
        case .systemSmall, .systemMedium:
            OTPCodeSystemSmall(entry: entry)
        #endif
        case .accessoryRectangular:
            OTPCodeAccessoryRectangular(entry: entry)
        case .accessoryCircular:
            OTPCodeAccessoryCircular(entry: entry)
        case .accessoryInline:
            OTPCodeAccessoryInline(entry: entry)
        default:
            Text(Texts.not_supported)
        }
    }
}
