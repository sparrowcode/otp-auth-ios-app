import SwiftUI

@available(iOS 15.0, watchOS 7.0, *)
public struct MarkupBorderView: View {
    
    let contentMargins: EdgeInsets
    
    public init(with contentMargins: EdgeInsets) {
        self.contentMargins = contentMargins
    }
    
    public var body: some View {
        ContainerRelativeShape()
            .strokeBorder(.white, lineWidth: 1)
            .padding(contentMargins.leading / 3)
            .blendMode(.plusLighter)
            .opacity(0.9)
    }
}
