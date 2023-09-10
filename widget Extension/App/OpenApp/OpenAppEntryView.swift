import WidgetKit
import SwiftBoost
import SwiftUI

struct OpenAppEntryView : View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: OpenAppProvider.Entry
    
    var body: some View {
        switch family {
#if os(iOS)
        case .systemSmall:
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .addBorder(Color.white, width: 2, cornerRadius: 16)
                    .cornerRadius(16)
                    .opacity(0.22)
                VStack(spacing: 4) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 4)
                    Image(systemName: "shield.fill")
                        .opacity(0.5)
                    Text(Texts.short_app_name)
                }
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.title)
            }
            .containerBackgroundForWidget {
                Color.blue
            }
#endif
        case .accessoryCircular:
            ZStack {
                Image(systemName: "shield.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                
            }
            .containerBackgroundForWidget {
                AccessoryWidgetBackground()
            }
        default:
            Text(Texts.not_supported)
        }
    }
}

#if os(iOS)
struct OpenAppEntryView_Preview: PreviewProvider {
    
    static var previews: some View {
        OpenAppEntryView(entry: .get())
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
#endif

extension View {
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
