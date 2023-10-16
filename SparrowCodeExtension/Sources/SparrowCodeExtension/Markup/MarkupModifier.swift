import SwiftUI

extension View {
    
    @available(iOS 15.0, watchOS 8.0, *)
    public func markup(inset: CGFloat) -> some View {
        self.modifier(MarkupRectangleModifier(inset: inset))
    }
}

@available(iOS 15.0, watchOS 8.0, *)
struct MarkupRectangleModifier: ViewModifier {
    
    let inset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                MarkupView(inset: inset)
                    .padding(-inset)
            }
    }
}
