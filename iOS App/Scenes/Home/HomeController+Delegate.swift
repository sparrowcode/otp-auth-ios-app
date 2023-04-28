import UIKit
import SPDiffable
import SPAlert
import NativeUIKit

extension HomeController: SPDiffableTableDelegate, SPDiffableTableMediator {
    
    func diffableTableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let item = diffableDataSource?.getItem(indexPath: indexPath) as? SPDiffableWrapperItem else { return false }
        let accountModel = item.model as? AccountModel
        return (accountModel == nil) ? false : true
    }
    
    func diffableTableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForItem item: SPDiffableItem, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let item = diffableDataSource?.getItem(indexPath: indexPath) as? SPDiffableWrapperItem else { return nil }
        guard let _ = item.model as? AccountModel else { return nil }
        
        let modelID = item.id
        let actionExport = UIContextualAction(style: .normal, title: Texts.Shared.export) { [weak self] action, view, completion in
            guard let self = self else { return }
            let link = self.passwordsData[indexPath.row].url
            let controller = ExportController(link: link.absoluteString)
            let navigationController = NativeNavigationController(rootViewController: controller)
            self.present(navigationController, animated: true)
            completion(true)
        }
        
        actionExport.backgroundColor = .systemIndigo
        actionExport.image = Images.export
        
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
                    if let url = URL(string: modelID) {
                        self.passwordsData.remove(at: indexPath.row)
                        KeychainStorage.delete(urls: [url])
                        AlertService.code_deleted()
                    }
                }
            let cancel = UIAlertAction(
                title: Texts.Shared.cancel,
                style: .cancel,
                handler: nil
            )
            
            alert.addAction(delete)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            completion(true)
        }
        
        actionDelete.image = Images.delete
        
        return UISwipeActionsConfiguration(actions: [actionDelete, actionExport])
    }
}
