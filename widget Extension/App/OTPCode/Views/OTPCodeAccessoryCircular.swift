import SwiftUI
import WidgetKit

struct OTPCodeAccessoryCircular: View {
    
    var entry: OTPCodeProvider.Entry
    
    var body: some View {
        ProgressView(
            timerInterval: entry.date...entry.date.addingTimeInterval(30),
            countsDown: true,
            label: {},
            currentValueLabel: {
                VStack(spacing: 0) {
                    Text(entry.otpCode.prefix(3))
                    Text(entry.otpCode.suffix(3))
                }
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .monospacedDigit()
            }
        )
        .progressViewStyle(.circular)
        .containerBackgroundForWidget {
            AccessoryWidgetBackground()
        }
        .widgetURL(OTPCodeEntry.getURL(for: entry))
    }
}
