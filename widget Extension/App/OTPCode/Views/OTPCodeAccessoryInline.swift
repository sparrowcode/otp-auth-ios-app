import SwiftUI
import WidgetKit

struct OTPCodeAccessoryInline: View {
    
    var entry: OTPCodeProvider.Entry
    
    var body: some View {
        Group {
            if let issuer = entry.issuer {
                Text(issuer + .space + entry.otpCode)
                    .widgetURL(OTPCodeEntry.getURL(for: entry))
            } else {
                Text(Texts.no_any_accounts)
            }
        }
        .containerBackgroundForWidget {
            AccessoryWidgetBackground()
        }
    }
}
