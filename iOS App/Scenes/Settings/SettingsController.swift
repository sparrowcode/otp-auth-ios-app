import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SettingsIconGenerator
import SafariServices
import MessageUI
import AlertKit

class SettingsController: SPDiffableTableController, MFMailComposeViewControllerDelegate, SFSafariViewControllerDelegate {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Texts.SettingsController.title
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.navigationController?.navigationBar.layoutMargins.left = view.layoutMargins.left
        self.navigationController?.navigationBar.layoutMargins.right = view.layoutMargins.left
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(
            alongsideTransition: { _ in
                self.navigationController?.navigationBar.layoutMargins.left = self.view.layoutMargins.left
                self.navigationController?.navigationBar.layoutMargins.right = self.view.layoutMargins.left
            },
            completion: nil
        )
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
        
        let appSection = SPDiffableSection(
            id: Section.app.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.app_section_footer),
            items: [
                NativeDiffableLeftButton(
                    id: Item.appearance.id,
                    text: Texts.SettingsController.appereance_button,
                    detail: nil,
                    icon: Images.appeareance,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        self.navigationController?.pushViewController(SettingsAppearanceController(style: .insetGrouped), animated: true)
                    }
                ),
                NativeDiffableLeftButton(
                    id: Item.sounds.id,
                    text: Texts.SettingsController.sounds_button,
                    detail: nil,
                    icon: Images.sounds,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        self.navigationController?.pushViewController(SettingsSoundsController(style: .insetGrouped), animated: true)
                    }
                ),
                NativeDiffableLeftButton(
                    id: Item.password.id,
                    text: Texts.SettingsController.Password.cell,
                    detail: nil,
                    icon: Images.password,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        self.navigationController?.pushViewController(SettingsPasswordController(style: .insetGrouped), animated: true)
                    }
                ),
                NativeDiffableLeftButton(
                    id: Item.languages.id,
                    text: Texts.SettingsController.language_button,
                    detail: nil,
                    icon: Images.language,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        self.navigationController?.pushViewController(SettingsLanguagesController(style: .insetGrouped), animated: true)
                    }
                )
            ]
        )
        sections.append(appSection)
        
        /*
        if Locale.current.languageCode == "ru" || Locale.current.languageCode == "uk" || Locale.current.languageCode == "be" || Locale.current.languageCode == "kk" {
            let mediaSection = SPDiffableSection(
                id: Section.media.id,
                header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.media_section_header),
                footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.media_section_footer),
                items: [
                    NativeDiffableLeftButton(
                        id: Item.website.id,
                        text: Texts.SettingsController.website_button,
                        detail: nil,
                        icon: Images.website,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.website_ru)
                        }
                    ),
                    NativeDiffableLeftButton(
                        id: Item.telegram.id,
                        text: Texts.SettingsController.telegram_button,
                        detail: nil,
                        icon: Images.telegram,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.telegram_ru)
                        }
                    ),
                    NativeDiffableLeftButton(
                        id: Item.twitter.id,
                        text: Texts.SettingsController.twitter_button,
                        detail: nil,
                        icon: Images.twitter,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.twitter_ru)
                        }
                    ),
                    NativeDiffableLeftButton(
                        id: Item.instagram.id,
                        text: Texts.SettingsController.instagram_button,
                        detail: nil,
                        icon: Images.instagram,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.instagram)
                        }
                    )
                ]
            )
            sections.append(mediaSection)
        } else {
            let mediaSection = SPDiffableSection(
                id: Section.media.id,
                header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.media_section_header),
                footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.media_section_footer),
                items: [
                    NativeDiffableLeftButton(
                        id: Item.website.id,
                        text: Texts.SettingsController.website_button,
                        detail: nil,
                        icon: Images.website,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.website_en)
                        }
                    ),
                    NativeDiffableLeftButton(
                        id: Item.telegram.id,
                        text: Texts.SettingsController.telegram_button,
                        detail: nil,
                        icon: Images.telegram,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.telegram_en)
                        }
                    ),
                    NativeDiffableLeftButton(
                        id: Item.twitter.id,
                        text: Texts.SettingsController.twitter_button,
                        detail: nil,
                        icon: Images.twitter,
                        accessoryType: .disclosureIndicator,
                        action: { item, indexPath in
                            self.openUrl(urlStr: Constants.Media.twitter_en)
                        }
                    )
                ]
            )
            sections.append(mediaSection)
        }*/
        
        let feedbackSection = SPDiffableSection(
            id: Section.feedback.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.feedback_section_header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.feedback_section_footer),
            items: [
                NativeDiffableLeftButton(
                    id: Item.telegram.id,
                    text: Texts.SettingsController.contact_button,
                    detail: nil,
                    icon: Images.telegram,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        let directURL = URL(string: "tg://resolve?domain=ivanvorobei")!
                        if UIApplication.shared.canOpenURL(directURL) {
                            UIApplication.shared.open(directURL)
                        } else {
                            self.openUrl(urlStr: "https://t.me/ivanvorobei")
                        }
                    }
                ),
                NativeDiffableLeftButton(
                    id: Item.feedback.id,
                    text: Texts.SettingsController.contact_button,
                    detail: nil,
                    icon: Images.contact,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        self.sendEmailToSupport()
                    }
                ),
                NativeDiffableLeftButton(
                    id: Item.about_app.id,
                    text: Texts.SettingsController.about_button,
                    detail: nil,
                    icon: Images.about,
                    accessoryType: .disclosureIndicator,
                    action: { item, indexPath in
                        self.navigationController?.pushViewController(SettingsAboutAppController(style: .insetGrouped), animated: true)
                    }
                )
            ]
        )
        sections.append(feedbackSection)
        /*
         let aboutSection = SPDiffableSection(
         id: Section.about.id,
         header: nil,
         footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.about_section_footer),
         items: [
         NativeDiffableLeftButton(
         id: Item.about_app.id,
         text: Texts.SettingsController.about_button,
         detail: nil,
         icon: Images.about,
         accessoryType: .disclosureIndicator,
         action: { item, indexPath in
         self.navigationController?.pushViewController(SettingsAboutAppController(style: .insetGrouped), animated: true)
         }
         )
         ]
         )
         sections.append(aboutSection)
         */
        
        return sections
    }
    
    enum Section: String {
        case app
        case feedback
        case media
        case about
        
        var id: String { rawValue }
    }
    
    enum Item: String {
        case appearance
        case sounds
        case password
        case languages
        case review
        case feedback
        case feedback_telegram
        case website
        case telegram
        case twitter
        case instagram
        case about_app
        
        var id: String { rawValue }
    }
    
    // MARK: - Actions
    
    func sendByURL(to: [String], subject: String, body: String, isHtml: Bool) -> Bool {
        
        var txtBody = body
        
        if isHtml {
            txtBody = body.replacingOccurrences(of: "<br />", with: "\n")
            txtBody = txtBody.replacingOccurrences(of: "<br/>", with: "\n")
            if txtBody.contains("/>") {
                return false
            }
        }
        
        let toJoined = to.joined(separator: ",")
        guard var feedbackUrl = URLComponents.init(string: "mailto:\(toJoined)") else {
            return false
        }
        
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem.init(name: "SUBJECT", value: subject))
        queryItems.append(URLQueryItem.init(name: "BODY",
                                            value: txtBody))
        feedbackUrl.queryItems = queryItems
        
        if let url = feedbackUrl.url {
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
                return true
            }
        }
        
        return false
    }
    
    func sendEmailToSupport() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([Constants.Email.feedback])
            mail.setSubject("OTP Authenticator")
            mail.setMessageBody(Texts.SettingsController.feedback_email_body, isHTML: true)
            present(mail, animated: true)
        } else {
            if !sendByURL(
                to: [Constants.Email.feedback],
                subject: "OTP Authenticator",
                body: Texts.SettingsController.feedback_email_body + " \(Texts.SettingsController.AboutApp.version_cell_detail):",
                isHtml: true
            ) { AlertService.email_error() }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func openUrl(urlStr: String) {
        if let url = URL(string: urlStr) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
}

