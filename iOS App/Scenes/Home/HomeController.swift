import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SettingsIconGenerator
import CameraPermission
import SPIndicator
import WidgetKit
import SafeSFSymbols

class HomeController: SPDiffableTableController {
    
    // MARK: - Views
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let headerView = RootControllerHeaderView()
    
    open var headerContainerView: HeaderContainerView
    private var cachedHeaderHeight: CGFloat? = nil
    var passwordsData: [AccountModel] = []
    var filteredData: [AccountModel] = []
    var scannedData: [String] = []
    
    // MARK: - Init
    
    public override init(style: UITableView.Style) {
        self.headerContainerView = HeaderContainerView(contentView: self.headerView)
        super.init(style: style)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Texts.HomeController.title
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        passwordsData = KeychainStorage.getAccounts()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.register(NativeEmptyTableViewCell.self)
        tableView.register(OTPTableViewCell.self)
        configureDiffable(sections: content, cellProviders: [.empty, .account] + SPDiffableTableDataSource.CellProvider.default)
        headerContainerView.setWidthAndFit(width: view.frame.width)
        tableView.tableHeaderView = headerContainerView
        diffableDataSource?.mediator = self
        diffableDataSource?.diffableDelegate = self
        
        headerView.scanButton.menu = .init(children: [
            UIAction(title: Texts.HomeController.scan_qr_code, image: .init(SafeSFSymbol.qrcode.viewfinder), handler: { _ in
                self.startScanningbyCamera()
            }),
            UIAction(title: Texts.HomeController.enter_code_manually, image: .init(SafeSFSymbol.keyboard), handler: { _ in
                let alertController = UIAlertController(
                    title: Texts.HomeController.enter_code_manually_alert_title,
                    message: Texts.HomeController.enter_code_manually_alert_description,
                    preferredStyle: .alert
                )
                alertController.addTextField { textField in
                    textField.text = nil
                    textField.placeholder = Texts.HomeController.enter_code_manually_alert_placeholder
                    textField.keyboardType = .URL
                    textField.addAction(.init(handler: { _ in
                        var enabled = false
                        if let value = textField.text, value.trim.count > 3 {
                            enabled = true
                        } else {
                            enabled = false
                        }
                        alertController.actions.first?.isEnabled = enabled
                    }), for: .editingChanged)
                }
                alertController.addAction(title: Texts.HomeController.enter_code_manually_alert_action_add) { _ in
                    if let text = alertController.textFields?.first?.text {
                        let processText = text.trim
                        if processText.hasPrefix("otpauth://"), let url = URL(string: processText) {
                            self.handledQR(tranformedData: text, url: url, controller: nil)
                        } else {
                            // Only secret
                            let accountAlertController = UIAlertController(title: Texts.HomeController.insert_account_title, message: Texts.HomeController.insert_account_description, preferredStyle: .alert)
                            accountAlertController.addTextField { textField in
                                textField.text = nil
                                textField.placeholder = Texts.HomeController.insert_account_placeholder
                                textField.addAction(.init(handler: { _ in
                                    var enabled = false
                                    if let value = textField.text, value.trim.count > 3 {
                                        enabled = true
                                    } else {
                                        enabled = false
                                    }
                                    alertController.actions.first?.isEnabled = enabled
                                }), for: .editingChanged)
                            }
                            accountAlertController.addAction(title: Texts.HomeController.insert_account_action_add, style: .default) { _ in
                                let account = accountAlertController.textFields?.first?.text ?? "Default Account"
                                let usingSecret = text.replace("-", with: "")
                                
                                var string = "otpauth://totp/\(account.trim)?secret=\(usingSecret.trim)&issuer=\(account.trim)"
                                string = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
                                
                                if let newurl = URL(string: string) {
                                    self.handledQR(tranformedData: newurl.absoluteString, url: newurl, controller: nil)
                                } else {
                                    AlertService.alertUndef(code: "Can't convert to URL")
                                }
                            }
                            accountAlertController.addAction(title: Texts.Shared.cancel)
                            self.present(accountAlertController)
                        }
                        // otpauth://totp/hello@ivanvorobei.io?secret=JBNWY3DPEHPK3PKD&issuer=Google
                        //self.handledQR(tranformedData: text, url: url, controller: nil)
                    }
                }
                alertController.addAction(title: Texts.Shared.cancel)
                alertController.actions.first?.isEnabled = false
                self.present(alertController)
            })
        ])
        headerView.scanButton.showsMenuAsPrimaryAction = true
        //headerView.scanButton.addTarget(self, action: #selector(startScanningbyCamera), for: .primaryActionTriggered)
        
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reload), userInfo: nil, repeats: true)
        
        NotificationCenter.default.addObserver(forName: .changedAccounts, object: nil, queue: nil) { notification in
            self.passwordsData = KeychainStorage.getAccounts()
            self.diffableDataSource?.set(self.content, animated: true)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gradeView = UIView()
        gradeView.backgroundColor = .systemBackground
        view.addSubview(gradeView)
        gradeView.frame = view.bounds
        UIView.animate(withDuration: 0.22, animations: {
            gradeView.alpha = 0
        }, completion: { finished in
            gradeView.removeFromSuperview()
        })
        diffableDataSource?.set(content, animated: false)
    }
    
    // MARK: Layout
    
    private var allowedLayoutInCycleForce = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.navigationController?.navigationBar.layoutMargins.left != view.layoutMargins.left {
            self.navigationController?.navigationBar.layoutMargins.left = view.layoutMargins.left
        }
        
        if self.navigationController?.navigationBar.layoutMargins.right != view.layoutMargins.right {
            self.navigationController?.navigationBar.layoutMargins.right = view.layoutMargins.right
        }
        
        var layoutContainer = false
        if headerContainerView.contentView.layoutMargins.left != tableView.layoutMargins.left {
            headerContainerView.contentView.layoutMargins.left = tableView.layoutMargins.left
            layoutContainer = true
        }
        if headerContainerView.contentView.layoutMargins.right != tableView.layoutMargins.right {
            headerContainerView.contentView.layoutMargins.right = tableView.layoutMargins.right
            layoutContainer = true
        }
        
        if allowedLayoutInCycleForce {
            layoutContainer = true
            allowedLayoutInCycleForce = false
        }
        
        if layoutContainer || (headerContainerView.frame.width != view.frame.width) {
            headerContainerView.setWidthAndFit(width: view.frame.width)
        }
        
        if cachedHeaderHeight != headerContainerView.frame.height {
            cachedHeaderHeight = headerContainerView.frame.height
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.diffableDataSource?.updateLayout(animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
        
        let accountsSection = SPDiffableSection(
            id: Section.accounts.id,
            header: SPDiffableTextHeaderFooter(text: Texts.HomeController.account_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.HomeController.account_section_footer),
            items: []
        )
        
        if isFiltering {
            for model in filteredData {
                let item = SPDiffableWrapperItem(
                    id: "\(model.url)",
                    model: model) { item, indexPath in
                        self.didTap(indexPath: indexPath)
                    }
                accountsSection.items.append(item)
            }
        } else {
            for model in passwordsData {
                let item = SPDiffableWrapperItem(
                    id: "\(model.url)",
                    model: model) { item, indexPath in
                        self.didTap(indexPath: indexPath)
                    }
                accountsSection.items.append(item)
            }
        }
        
        if accountsSection.items.isEmpty {
            accountsSection.items.append(
                NativeEmptyRowItem.init(
                    id: "empty cell",
                    verticalMargins: .large,
                    text: Texts.HomeController.empty_cell_title,
                    detail: Texts.HomeController.empty_cell_subitle)
            )
        }
        
        sections.append(accountsSection)
        
        let settingsSection = SPDiffableSection(
            id: Section.settings.id,
            header: nil,
            footer: SPDiffableTextHeaderFooter(text: Texts.HomeController.settings_section_footer),
            items: [
                NativeDiffableLeftButton(
                    id: "settings button",
                    text: Texts.HomeController.settings_button,
                    detail: nil,
                    icon: Images.settings,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        let settingsVC = NativeNavigationController.init(rootViewController: SettingsController(style: .insetGrouped))
                        settingsVC.modalPresentationStyle = .fullScreen
                        self.present(settingsVC, animated: true, completion: nil)
                    }
                )
            ]
        )
        
        let showContact: Bool = {
            if #available(iOS 16, *) {
                guard let regionCode = Locale.current.region?.identifier.lowercased() else { return false }
                let support = ["ru", "by", "uk", "kk"]
                return support.contains(regionCode)
            } else {
                return false
            }
        }()
        
        if (showContact) {
            settingsSection.items.insert(
                NativeDiffableLeftButton(
                    id: "settings telegram",
                    text: Texts.SettingsController.contact_button,
                    detail: nil,
                    icon: Images.telegram,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        let directURL = URL(string: "tg://resolve?domain=ivanvorobei")!
                        if UIApplication.shared.canOpenURL(directURL) {
                            UIApplication.shared.open(directURL)
                        } else {
                            UIApplication.shared.open(.init(string: "https://t.me/ivanvorobei")!)
                        }
                    }
                ),
                at: 0
            )
        }
        
        sections.append(settingsSection)
        
        return sections
    }
    
    private func didTap(indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) as? OTPTableViewCell else { return }
        cell.copyButton.isHighlighted = true
        if let code = cell.password {
            debug("Copied code \(code)")
            UIPasteboard.general.string = cell.password
            AlertService.copied()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cell.copyButton.isHighlighted = false
            }
        }
    }
    
    enum Section: String {
        
        case accounts
        case settings
        
        var id: String { rawValue }
    }
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}
