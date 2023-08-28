import Foundation
import WidgetKit

struct OpenAppEntry: TimelineEntry {

    let date: Date
    
    static func get() -> OpenAppEntry {
        return OpenAppEntry(date: .now)
    }
}
