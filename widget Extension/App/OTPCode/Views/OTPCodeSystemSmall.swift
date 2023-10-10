import SwiftUI
import SwiftUIExtension
import SparrowCodeExtension

#if os(iOS)
struct OTPCodeSystemSmall: View {
    
    var entry: OTPCodeProvider.Entry
    
    @Environment(\.widgetContentMarginsCompability) var margins
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                HStack(spacing: 2) {
                    Image(systemName: "shield.fill")
                    Text(Texts.short_app_name)
                }
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.caption)
                .markup(inset: Spaces.step * 2)
                .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
            }
            if let issuer = entry.issuer {
                VStack(spacing: 6) {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Spacer()
                            Text(issuer)
                                .foregroundColor(.black)
                                .opacity(0.8)
                                .fontWeight(.medium)
                                .font(.footnote)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .opacity(0.7)
                                .markup(inset: Spaces.default_less)
                            Text(entry.otpCode)
                                .monospacedDigit()
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .markup(inset: Spaces.default_less)
                        }
                        Spacer()
                        if widgetFamily == .systemMedium {
                            VStack(alignment: .trailing) {
                                Spacer()
                                Text(timerInterval: entry.date...entry.date.addingTimeInterval(30),
                                     countsDown: true)
                                .monospacedDigit()
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title)
                                .lineLimit(1)
                                .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                    
                    ProgressView(
                        timerInterval: entry.date...entry.date.addingTimeInterval(30),
                        countsDown: true,
                        label: {},
                        currentValueLabel: {
                            if widgetFamily != .systemMedium {
                                Text(timerInterval: entry.date...entry.date.addingTimeInterval(30), countsDown: true)
                                    .monospacedDigit()
                                    .foregroundColor(.white.opacity(0.85))
                                    .fontWeight(.medium)
                            }
                        }
                    )
                    .tint(.white)
                    .progressViewStyle(.linear)
                }
            } else {
                Text(Texts.no_any_accounts)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.3)
            }
        }
        .containerBackgroundForWidget {
            ZStack {
                Color.accentColor
                MarkupBorderView(with: margins)
            }
        }
        .widgetURL(OTPCodeEntry.getURL(for: entry))
    }
}
#endif
