import SwiftUI
import WidgetKit

struct OpenAppProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> OpenAppEntry {
        return .get()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (OpenAppEntry) -> Void) {
        completion(.get())
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<OpenAppEntry>) -> Void) {
        let timeline = Timeline<OpenAppEntry>(entries: [.get()], policy: .never)
        completion(timeline)
    }
}
