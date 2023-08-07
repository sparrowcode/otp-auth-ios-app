import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SettingsIconGenerator

class SettingsPasswordController: SPDiffableTableController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.Password.title
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
        
        let appSection = SPDiffableSection(
            id: Section.password.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Password.header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Password.footer),
            items: [
                SPDiffableTableRowSwitch(
                    id: "password",
                    text: Texts.SettingsController.Password.cell,
                    icon: nil,
                    isOn: Settings.isPasswordEnabled,
                    action: { currentState in
                        AppLocalAuthentication.request(reason: Texts.Auth.change_description) { (state) in
                            if state {
                                Settings.isPasswordEnabled = currentState
                                self.diffableDataSource?.set(self.content, animated: true)
                            } else {
                                self.diffableDataSource?.set(self.content, animated: true)
                            }
                            
                        }
                    }
                )
            ]
        )
        sections.append(appSection)
        
        let showWidgetSection = SPDiffableSection(
            id: Section.show_widget.id,
            header: nil,
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Password.allow_widget_footer),
            items: [
                SPDiffableTableRowSwitch(
                    id: "allow-widget",
                    text: Texts.SettingsController.Password.allow_widget,
                    icon: nil,
                    isOn: !Settings.hideWidgetData,
                    action: { currentState in
                        AppLocalAuthentication.request(reason: Texts.Auth.change_description) { (state) in
                            if state {
                                Settings.hideWidgetData = !Settings.hideWidgetData
                                
                            }
                            self.diffableDataSource?.set(self.content, animated: true)
                        }
                    }
                )
            ]
        )
        sections.append(showWidgetSection)
        
        return sections
    }
    
    enum Section: String {
        
        case password
        case show_widget
        
        var id: String { rawValue }
    }
    
}
