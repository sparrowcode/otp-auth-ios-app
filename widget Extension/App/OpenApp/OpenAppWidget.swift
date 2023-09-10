import WidgetKit
import SwiftUI

struct OpenAppWidget: Widget {
    
    let kind: String = "OpenAppWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: OpenAppProvider()
        ) { entry in
            OpenAppEntryView(entry: entry)
        }
        .configurationDisplayName(Texts.widget_open_app_title)
        .description(Texts.widget_open_app_description)
        .supportedFamilies(supportedFamilies)
    }
    
    private var supportedFamilies: [WidgetFamily] {
        #if os(iOS)
        return [.systemSmall, .accessoryCircular]
        #endif
        #if os(watchOS)
        return [.accessoryCircular]
        #endif
    }
}
