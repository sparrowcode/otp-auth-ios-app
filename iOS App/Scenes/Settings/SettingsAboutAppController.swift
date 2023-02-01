import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SPSettingsIcons
import KeychainAccess
import SafariServices

class SettingsAboutAppController: SPDiffableTableController, SFSafariViewControllerDelegate {
    
    var fakeDataClicks = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.AboutApp.title
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
        
        let versionSection = SPDiffableSection(
            id: Section.version.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.AboutApp.version_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.AboutApp.version_footer),
            items: [
                SPDiffableTableRow(
                    id: "Version",
                    text: Texts.SettingsController.AboutApp.version_cell_title,
                    detail: Texts.SettingsController.AboutApp.version_cell_detail,
                    icon: nil,
                    accessoryType: .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.fakeDataClicks += 1
                        if self.fakeDataClicks == 5 {
                            self.callMenu()
                            self.fakeDataClicks = 0
                        }
                    }
                )
            ]
        )
        sections.append(versionSection)
        
        let openSourceSection = SPDiffableSection(
            id: Section.openSource.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.AboutApp.openSource_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.AboutApp.openSource_footer),
            items: [
                SPDiffableTableRow(
                    id: "Open Source",
                    text: Texts.SettingsController.AboutApp.openSource_cell_title,
                    detail: nil,
                    icon: Images.github,
                    accessoryType: .disclosureIndicator,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.openUrl(urlStr: Constants.Media.github)
                    }
                )
            ]
        )
        sections.append(openSourceSection)
        
        /*
         let packagesSection = SPDiffableSection(
         id: Section.package.id,
         header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_header),
         footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_footer),
         items: [
         SPDiffableTableRow(
         id: "Version",
         text: Texts.SettingsController.AboutApp.version_cell_title,
         detail: Texts.SettingsController.AboutApp.version_cell_detail,
         icon: nil,
         accessoryType: .none,
         selectionStyle: .none,
         action: nil
         )
         ]
         )
         */
        
        return sections
    }
    
    enum Section: String {
        case version
        case openSource
        case package
        
        var id: String { rawValue }
    }
    
    private func callMenu() {
        
        let alert = UIAlertController(
            title: "Developer Menu",
            message: "Actions for developers. Don't use it if you don't know what it do.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Add Fake Data",
                style: UIAlertAction.Style.destructive,
                handler: { _ in
                    
                    let fakeData = [
                        "otpauth://totp/hello@sparrowcode.io?secret=JBSWY3DPEHPK3PXP&issuer=SparrowCode",
                        "otpauth://totp/ivanvorobei@sparrowcode.io?secret=JBSWY3DPEHPK3PFD&issuer=Sketch",
                        "otpauth://totp/hello@ivanvorobei.io?secret=JBSWY3DPEHPK3PKD&issuer=DigitalOcean"
                    ]
                    var fakeURLs: [URL] = []
                    for rawString in fakeData {
                        if let url = URL(string: rawString) {
                            fakeURLs.append(url)
                        }
                    }
                    
                    KeychainStorage.delete(urls: fakeURLs)
                    KeychainStorage.add(urls: fakeURLs)
                    
                    let alert = UIAlertController(
                        title: "Fake Data Added",
                        message: "You can delete them like any other account.",
                        preferredStyle: UIAlertController.Style.alert
                    )
                    
                    alert.addAction(
                        UIAlertAction(
                            title: Texts.Shared.OK,
                            style: UIAlertAction.Style.cancel,
                            handler: nil
                        )
                    )
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
            )
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Clear Keychain",
                style: UIAlertAction.Style.destructive,
                handler: { _ in
                    
                    let alert = UIAlertController(
                        title: "Clear Keychain?",
                        message: "All your accounts will be permamently deleted. They cannot be restored anymore.",
                        preferredStyle: UIAlertController.Style.alert
                    )
                    
                    alert.addAction(
                        UIAlertAction(
                            title: "Clear",
                            style: UIAlertAction.Style.destructive,
                            handler: { _ in
                                
                                let keychain = Keychain(service: Constants.Keychain.service)
                                try! keychain.removeAll()
                                NotificationCenter.default.post(name: .changedAccounts)
                                
                                let alert = UIAlertController(
                                    title: "Keychain Cleaned",
                                    message: "All your accounts were permamently deleted. They cannot be restored anymore.",
                                    preferredStyle: UIAlertController.Style.alert
                                )
                                
                                alert.addAction(
                                    UIAlertAction(
                                        title: Texts.Shared.OK,
                                        style: UIAlertAction.Style.cancel,
                                        handler: nil
                                    )
                                )
                                
                                self.present(alert, animated: true, completion: nil)
                            }
                        )
                    )
                    
                    alert.addAction(
                        UIAlertAction(
                            title: Texts.Shared.cancel,
                            style: UIAlertAction.Style.cancel,
                            handler: nil
                        )
                    )
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
            )
        )
        
        alert.addAction(
            UIAlertAction(
                title: Texts.Shared.cancel,
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func openUrl(urlStr: String) {
        if let url = URL(string: urlStr) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
}
