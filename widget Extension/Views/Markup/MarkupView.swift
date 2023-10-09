import SwiftUI

struct MarkupView: View {
    
    let inset: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            
            let frame = proxy.frame(in: .local)
            
            Path { path in
                path.move(
                    to: .init(
                        x: frame.minX + inset,
                        y: frame.minY
                    )
                )
                path.addLine(
                    to: .init(
                        x: frame.minX + inset,
                        y: frame.maxY
                    )
                )
                path.move(
                    to: .init(
                        x: frame.maxX - inset,
                        y: frame.minY
                    )
                )
                path.addLine(
                    to: .init(
                        x: frame.maxX - inset,
                        y: frame.maxY
                    )
                )
                path.move(
                    to: .init(
                        x: frame.minX,
                        y: frame.minY + inset
                    )
                )
                path.addLine(
                    to: .init(
                        x: frame.maxX,
                        y: frame.minY + inset
                    )
                )
                path.move(
                    to: .init(
                        x: frame.minX,
                        y: frame.maxY - inset
                    )
                )
                path.addLine(
                    to: .init(
                        x: frame.maxX,
                        y: frame.maxY - inset
                    )
                )
            }
            .stroke(Color.white, lineWidth: 1)
            .mask {
                EllipticalGradient(
                    colors: [.white, .white.opacity(0)],
                    startRadiusFraction: 0.33,
                    endRadiusFraction: 0.6
                )
                /*RadialGradient(
                 colors: [.white, .white.opacity(.zero)],
                 center: .center,
                 startRadius: frame.size.width / 2.1,
                 endRadius: frame.size.width / 1.7
                 )*/
            }
            .opacity(0.2)
            .blendMode(.plusLighter)
        }
    }
}
