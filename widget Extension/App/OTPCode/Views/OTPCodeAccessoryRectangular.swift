import SwiftUI
import WidgetKit

struct OTPCodeAccessoryRectangular: View {
    
    var entry: OTPCodeProvider.Entry
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 2) {
                if let account = entry.configuration.account {
                    Text(account.issuer ?? .empty)
                        .foregroundColor(.secondary)
                        .opacity(0.8)
                        .fontWeight(.semibold)
                        .font(.body)
                        .lineLimit(1)
                        .opacity(0.7)
                        .minimumScaleFactor(0.5)
                    Text(entry.otpCode)
                        .monospacedDigit()
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    ProgressView(
                        timerInterval: entry.date...entry.date.addingTimeInterval(30),
                        countsDown: true,
                        label: {},
                        currentValueLabel: {}
                    )
                    .padding(.horizontal)
                } else {
                    Text(Texts.no_any_accounts)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                }
            }
        }
        .containerBackgroundForWidget {
            AccessoryWidgetBackground()
        }
        .widgetURL(OTPCodeEntry.getURL(for: entry))
    }
}
