import SPDiffable
import UIKit

extension SPDiffableTableDataSource.CellProvider {
    
    public static var account: SPDiffableTableDataSource.CellProvider  {
        return SPDiffableTableDataSource.CellProvider() { (tableView, indexPath, item) -> UITableViewCell? in
            guard let model = (item as? SPDiffableWrapperItem)?.model as? AccountModel else { return nil }
            let cell = tableView.dequeueReusableCell(withClass: OTPTableViewCell.self, for: indexPath)
            cell.sizeToFit()
            cell.selectionStyle = .default
            cell.updateCell(model: model)
            
            return cell
        }
    }
    
    public static var color: SPDiffableTableDataSource.CellProvider {
        return SPDiffableTableDataSource.CellProvider() { (tableView, indexPath, item) -> UITableViewCell? in
            guard let item = item as? DiffableTableColorRow else { return nil }
            let cell = tableView.dequeueReusableCell(withClass: ColorTableViewCell.self, for: indexPath)
            cell.textLabel?.text = item.text
            cell.imageView?.image = item.icon
            cell.accessoryType = item.accessoryType
            cell.selectionStyle = item.selectionStyle
            return cell
        }
    }
    
}
