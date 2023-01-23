import UIKit
import SPDiffable
import SPAlert
import NativeUIKit

extension HomeController: SPDiffableTableDelegate, SPDiffableTableMediator {
    
    func diffableTableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func diffableTableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForItem item: SPDiffableItem, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modelID = item.id
        var actions = UISwipeActionsConfiguration(actions: [])
        if indexPath.section == 0 {
            if !passwordsData.isEmpty {
                
                let actionExport = UIContextualAction(style: .normal, title: Texts.Shared.export) { [weak self] action, view, completion in
                    guard let self = self else { return }
                    let link = self.passwordsData[indexPath.row].url
                    let controller = ExportController(link: link.absoluteString)
                    let navigationController = NativeNavigationController(rootViewController: controller)
                    self.present(navigationController, animated: true)
                    
                    
                }
                actionExport.backgroundColor = .systemYellow
                
                let actionDelete = UIContextualAction(style: .destructive, title: Texts.Shared.delete) { [weak self] action, view, completion in
                    guard let self = self else { return }
                    
                    let alert = UIAlertController(
                        title: Texts.HomeController.delete_alert_title,
                        message: Texts.HomeController.delete_alert_message,
                        preferredStyle: .actionSheet
                    )
                    let delete = UIAlertAction(
                        title: Texts.Shared.delete,
                        style: .destructive) { alert in
                            self.passwordsData.remove(at: indexPath.row)
                            KeychainStorage.remove(rawURLs: [modelID])
                            AlertService.code_deleted()
                        }
                    let cancel = UIAlertAction(
                        title: Texts.Shared.cancel,
                        style: .cancel,
                        handler: nil
                    )
                    alert.addAction(delete)
                    alert.addAction(cancel)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                let codeActions = UISwipeActionsConfiguration(actions: [actionDelete, actionExport])
                actions = codeActions
            }
        }
        return actions
    }
}
