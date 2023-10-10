import WidgetKit
import SwiftUI
import Intents

@main
struct OTPWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        OTPCodeWidget()
        OpenAppWidget()
    }
}

#if os(iOS)
@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    OTPCodeWidget()
} timeline: {
    OTPCodeEntry.preview
}
#endif
