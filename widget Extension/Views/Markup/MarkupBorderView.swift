import SwiftUI

struct MarkupBorderView: View {
    
    let margins: EdgeInsets
    
    var body: some View {
        ContainerRelativeShape()
            .strokeBorder(.white, lineWidth: 1)
            .padding(margins.leading / 3)
            .blendMode(.plusLighter)
            .opacity(0.95)
    }
}
