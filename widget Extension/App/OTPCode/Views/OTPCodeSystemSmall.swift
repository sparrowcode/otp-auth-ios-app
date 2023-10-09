import SwiftUI
import SwiftUIExtension

#if os(iOS)
struct OTPCodeSystemSmall: View {
    
    var entry: OTPCodeProvider.Entry
    
    @State private var codeFrame: CGRect = .zero
    @State private var accountFrame: CGRect = .zero
    
    @Environment(\.widgetContentMarginsCompability) var margins
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
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
                                .background {
                                    GeometryReader { proxy in
                                        Color.clear
                                            .onAppear {
                                                accountFrame = proxy.frame(in: .global)
                                            }
                                            .onChange(of: proxy.size) { newValue in
                                                accountFrame = proxy.frame(in: .global)
                                            }
                                    }
                                    
                                }
                            Text(entry.otpCode)
                                .monospacedDigit()
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.title)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .background {
                                    GeometryReader { proxy in
                                        Color.clear
                                            .onAppear {
                                                codeFrame = proxy.frame(in: .global)
                                            }
                                            .onChange(of: proxy.size) { newValue in
                                                codeFrame = proxy.frame(in: .global)
                                            }
                                    }
                                    
                                }
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
                    VStack {
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
            
            Color.accentColor
            
            MarkupBorderView(margins: margins)
            
            let codeInsets: CGFloat = Spaces.default_less
            MarkupView(inset: codeInsets)
                .frame(
                    width: codeFrame.width + codeInsets * 2,
                    height: codeFrame.height + codeInsets * 2
                )
                .position(
                    x: codeFrame.midX,
                    y: codeFrame.midY
                )
            
            let accountInsets: CGFloat = Spaces.default
            MarkupView(inset: codeInsets)
                .frame(
                    width: accountFrame.width + codeInsets * 2,
                    height: accountFrame.height + codeInsets * 2
                )
                .position(
                    x: accountFrame.midX,
                    y: accountFrame.midY
                )
            
        }
        .widgetURL(OTPCodeEntry.getURL(for: entry))
    }
}
#endif
