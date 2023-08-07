import UIKit
import SparrowKit
import NativeUIKit
import SPDiffable
import SettingsIconGenerator

class SettingsSoundsController: SPDiffableTableController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Texts.SettingsController.Sounds.title
        configureDiffable(sections: content, cellProviders: SPDiffableTableDataSource.CellProvider.default)
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // MARK: - Actions
    
    func updateSounds(state: String) {
        Settings.isSoundsEnabled = state
        UIFeedbackGenerator.impactOccurred(.selectionChanged)
        self.diffableDataSource?.set(self.content, animated: true)
    }
    
    
    // MARK: - Diffable
    
    var content: [SPDiffableSection] {
        var sections: [SPDiffableSection] = []
 
        let appSection = SPDiffableSection(
            id: Section.password.id,
            header: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Sounds.header),
            footer: SPDiffableTextHeaderFooter(text: Texts.SettingsController.Sounds.footer),
            items: [
                SPDiffableTableRow(
                    id: "sounds_enabled_row",
                    text: Texts.SettingsController.Sounds.enabled,
                    detail: nil,
                    icon: nil,
                    accessoryType: Settings.isSoundsEnabled == "1" ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.updateSounds(state: "1")
                    }
                ),
                SPDiffableTableRow(
                    id: "sounds_disabled_row",
                    text: Texts.SettingsController.Sounds.disabled,
                    detail: nil,
                    icon: nil,
                    accessoryType: Settings.isSoundsEnabled == "2" ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.updateSounds(state: "2")
                    }
                ),
                SPDiffableTableRow(
                    id: "sounds_during_day_row",
                    text: Texts.SettingsController.Sounds.during_day,
                    detail: nil,
                    icon: nil,
                    accessoryType: Settings.isSoundsEnabled == "3" ? .checkmark : .none,
                    selectionStyle: .none,
                    action: { item, indexPath in
                        self.updateSounds(state: "3")
                    }
                )
                
            ]
        )
        sections.append(appSection)
        
        return sections
    }
    
    enum Section: String {
        case password
        
        var id: String { rawValue }
    }
    
}
