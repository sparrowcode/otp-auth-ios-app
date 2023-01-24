import UIKit
import SparrowKit
import NativeUIKit

extension ExportController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.layout(y: scrollView.layoutMargins.top)
        
        let side = scrollView.frame.height > 400 ? scrollView.frame.width / 2 : scrollView.frame.height / 3
        
        exportButton.frame = .init(x: 0, y: headerView.frame.maxY + 35, width: side, height: side)
        exportButton.setXCenter()
        
        exportLabel.layoutDynamicHeight(
            x: 0,
            y: exportButton.frame.maxY + 12,
            width: exportButton.frame.width - 20
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
