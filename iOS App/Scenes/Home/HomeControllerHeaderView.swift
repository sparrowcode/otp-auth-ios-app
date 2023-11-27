import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SafeSFSymbols

class RootControllerHeaderView: SPView {

    // MARK: - Views

    let scanButton = NativeLargeActionButton().do {
        $0.set(
            title: Texts.HomeController.header_view_action,
            icon: .init(SafeSFSymbol.plus.circleFill),
            colorise: .init(content: .tint, background: .tint.alpha(0.1))
        )
    }

    let footerLabel = SPLabel().do {
        $0.font = .preferredFont(forTextStyle: .footnote)
        $0.numberOfLines = .zero
        $0.textAlignment = .left
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .secondaryLabel
        $0.text = Texts.HomeController.header_view_description
    }

    // MARK: - Init

    override func commonInit() {
        super.commonInit()
        layoutMargins = .init(horizontal: 16, vertical: 16)
        addSubviews([scanButton, footerLabel])
    }

    // MARK: Layout
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        scanButton.set(
            title: Texts.HomeController.header_view_action,
            icon: .init(SafeSFSymbol.plus.circleFill),
            colorise: .init(content: .tint, background: .tint.alpha(0.1))
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        scanButton.layout(y: .zero)
        scanButton.frame.origin.x = readableMargins.left

        footerLabel.layoutDynamicHeight(
            x: scanButton.frame.origin.x + 8,
            y: scanButton.frame.maxY + 8,
            width: readableWidth - 8
        )
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        layoutSubviews()
        return CGSize.init(
            width: size.width,
            height: (footerLabel.frame.maxY + layoutMargins.bottom).rounded(.up)
        )
    }
}
