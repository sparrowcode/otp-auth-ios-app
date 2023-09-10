import WidgetKit
import SwiftUI
import Intents

@main
struct WidgetsBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        OTPCodeWidget()
        OpenAppWidget()
    }
}
