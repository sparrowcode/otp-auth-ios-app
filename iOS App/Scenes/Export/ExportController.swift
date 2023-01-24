import UIKit
import SparrowKit
import NativeUIKit

class ExportController: SPScrollController {
    
    // MARK: - Views
    
    var copyLink: String
    
    let headerView = NativeModalHeaderView(
        image: nil,
        title: Texts.ExportController.title,
        subtitle: Texts.ExportController.description
    )
    let exportButton = QRExportButton()
    let exportLabel = SPLabel(text: Texts.ExportController.footer).do {
        $0.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        $0.textAlignment = .center
        $0.textColor = .secondaryLabel
        $0.numberOfLines = .zero
    }
    let closeButton = NativeLargeActionButton().do {
        $0.set(
            title: Texts.Shared.close,
            icon: Images.export,
            colorise: .init(content: .tint, background: .clear)
        )
    }
    
    // MARK: - Init
    
    init(link: String) {
        
        self.copyLink = link
        super.init()
        let image = generateQRCode(from: link)
        exportButton.qrImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = closeBarButtonItem
        view.backgroundColor = .systemBackground
        exportButton.addTarget(self, action: #selector(copyQR), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        scrollView.addSubviews([headerView, exportButton, exportLabel, closeButton])
    }
}
