import WidgetKit
import SwiftBoost
import SwiftUI
import Intents
import OTP

struct OTPCodeEntryView : View {
    
    static func getURL(for entry: OTPCodeProvider.Entry) -> URL? {
        return URL(string: "otpauth://copycode?code=\(entry.otpCode.replacingOccurrences(of: " ", with: ""))")
    }
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: OTPCodeProvider.Entry
    
    var body: some View {
        switch family {
#if os(iOS)
        case .systemSmall, .systemMedium:
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                ZStack {
                    VStack {
                        HStack(spacing: 2) {
                            Spacer()
                            Image(systemName: "shield.fill")
                            Text(Texts.short_app_name)
                        }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.caption)
                        Spacer()
                    }
                    if let issuer = entry.issuer {
                        VStack(spacing: 0) {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Spacer()
                                    Text(issuer)
                                        .foregroundColor(.black)
                                        .opacity(0.8)
                                        .fontWeight(.medium)
                                        .font(.footnote)
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                        .opacity(0.7)
                                    Text(entry.otpCode)
                                        .monospacedDigit()
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title)
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                if family == .systemMedium {
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
                            VStack {
                                ProgressView(
                                    timerInterval: entry.date...entry.date.addingTimeInterval(30),
                                    countsDown: true,
                                    label: {},
                                    currentValueLabel: {
                                        if family != .systemMedium {
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
                .padding()
            }
            .widgetURL(OTPCodeEntryView.getURL(for: entry))
#endif
        case .accessoryRectangular:
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
            .widgetURL(OTPCodeEntryView.getURL(for: entry))
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
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
            }
            .widgetURL(OTPCodeEntryView.getURL(for: entry))
        case .accessoryInline:
            if let issuer = entry.issuer {
                Text(issuer + .space + entry.otpCode)
                    .widgetURL(OTPCodeEntryView.getURL(for: entry))
            } else {
                Text(Texts.no_any_accounts)
            }
            
        default:
            Text(Texts.not_supported)
        }
    }
}

struct OTPWidgetEntryView_Preview: PreviewProvider {
    
    static var previews: some View {
        OTPCodeEntryView(entry: .init(otpCode: "123456", issuer: "sparrowcode.io", date: .now, configuration: SelectAccountIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
