import UIKit
import SparrowKit
import NativeUIKit

extension ExportController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.layout(y: 0)
        
        let side = min(270, scrollView.readableWidth / 2, view.frame.height * 0.5)
        
        exportButton.frame = .init(x: 0, y: headerView.frame.maxY + 35, width: side, height: side)
        exportButton.setXCenter()
        
        exportLabel.layoutDynamicHeight(
            x: 0,
            y: exportButton.frame.maxY + 12,
            width: min(220, scrollView.readableWidth / 2)
        )
        exportLabel.setXCenter()
        
        let closeButtonY = scrollView.frame.height > 400 ? (scrollView.frame.height - (scrollView.layoutMargins.bottom * 4)) : exportLabel.frame.maxY + 35
        closeButton.layout(y: closeButtonY)
        
        scrollView.contentSize = .init(
            width: scrollView.frame.width,
            height: closeButton.frame.maxY
        )
    }
    
}
