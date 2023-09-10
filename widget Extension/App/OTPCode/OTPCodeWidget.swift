import WidgetKit
import SwiftUI
import Intents
import OTP

struct OTPCodeWidget: Widget {
    
    let kind: String = "OTPCodeWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: SelectAccountIntent.self,
            provider: OTPCodeProvider()
        ) { entry in
            OTPCodeEntryView(entry: entry)
        }
        .configurationDisplayName(Texts.widget_otp_code_title)
        .description(Texts.widget_otp_code_description)
        .supportedFamilies(supportedFamilies)
    }
    
    private var supportedFamilies: [WidgetFamily] {
        #if os(iOS)
        return [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular, .accessoryInline]
        #endif
        #if os(watchOS)
        return [.accessoryRectangular, .accessoryCircular, .accessoryInline]
        #endif
    }
}
