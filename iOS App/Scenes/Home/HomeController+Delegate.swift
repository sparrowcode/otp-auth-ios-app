import UIKit
import SPDiffable
import AlertKit
import NativeUIKit

extension HomeController: SPDiffableTableDelegate, SPDiffableTableMediator {
    
    func diffableTableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let item = diffableDataSource?.getItem(indexPath: indexPath) as? SPDiffableWrapperItem else { return false }
        let accountModel = item.model as? AccountModel
        return (accountModel == nil) ? false : true
    }
    
    func diffableTableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForItem item: SPDiffableItem, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let item = diffableDataSource?.getItem(indexPath: indexPath) as? SPDiffableWrapperItem else { return nil }
        guard let accountModel = item.model as? AccountModel else { return nil }
        
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
        
        let renameAction = UIContextualAction(style: .normal, title: Texts.HomeController.Rename.title) { [weak self] action, view, completion in
            guard let self = self else { return }
            self.processRename(indexPath: indexPath, model: accountModel)
            completion(true)
        }
        renameAction.backgroundColor = .systemBlue
        renameAction.image = Images.rename
        
        let actionDelete = UIContextualAction(style: .destructive, title: Texts.Shared.delete) { [weak self] action, view, completion in
            guard let self = self else { return }
            
            let alert = UIAlertController(
                title: Texts.HomeController.delete_alert_title,
                message: Texts.HomeController.delete_alert_message,
                preferredStyle: .actionSheet
            )
            alert.popoverPresentationController?.sourceView = tableView.cellForRow(at: indexPath)
            alert.popoverPresentationController?.sourceRect = tableView.cellForRow(at: indexPath)?.bounds ?? .zero
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
        
        return UISwipeActionsConfiguration(actions: [actionDelete, renameAction, actionExport])
    }
    
    fileprivate func processRename(indexPath : IndexPath, model: AccountModel) {
        let alertController = UIAlertController(
            title: Texts.HomeController.Rename.set_new_name_title,
            message: Texts.HomeController.Rename.set_new_name_description,
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.text = model.login
            textField.placeholder = Texts.HomeController.account_title
            textField.keyboardType = .emailAddress
            textField.addAction(.init(handler: { _ in
                alertController.actions.first?.isEnabled = self.allowedRename(for: alertController)
            }), for: .editingChanged)
        }
        
        alertController.addTextField { textField in
            textField.text = model.issuer
            textField.placeholder = Texts.HomeController.issuer_title
            textField.keyboardType = .default
            textField.addAction(.init(handler: { _ in
                alertController.actions.first?.isEnabled = self.allowedRename(for: alertController)
            }), for: .editingChanged)
        }
        
        alertController.popoverPresentationController?.sourceView = tableView.cellForRow(at: indexPath)
        alertController.popoverPresentationController?.sourceRect = tableView.cellForRow(at: indexPath)?.bounds ?? .zero
        
        alertController.addAction(title: Texts.HomeController.Rename.title) { _ in
            let url = model.url
            self.passwordsData.remove(at: indexPath.row)
            KeychainStorage.delete(urls: [url])
            
            let newModel = model
            newModel.issuer = alertController.textFields?[1].text ?? .empty
            newModel.login = alertController.textFields?[0].text ?? .empty
            KeychainStorage.add(urls: [newModel.url])
            
            AlertKitAPI.present(title: Texts.HomeController.Rename.completed_renamed, subtitle: nil, icon: .done, style: .iOS17AppleMusic, haptic: .success)
        }
        alertController.addAction(title: Texts.Shared.cancel)
        alertController.actions.first?.isEnabled = allowedRename(for: alertController)
        self.present(alertController)
    }
    
    fileprivate func allowedRename(for alert: UIAlertController) -> Bool {
        for textField in alert.textFields ?? [] {
            if (textField.text ?? .space).trim.count < 1 { return false }
        }
        return true
    }
}
